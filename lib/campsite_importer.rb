require 'httparty'
require 'pp'
require 'ostruct'

class CampsiteImporter
  include HTTParty

  base_uri 'http://api.amp.active.com/camping'

  def initialize(api_key)
    self.class.default_params('api_key' => api_key)
  end

  def import
    clear_all
    campsites = import_campgrounds
    campsites.each do |campsite|
      import_campground_details(campsite)
      import_campsites(campsite)
    end
  end

  private

  def clear_all
    Campsite.delete_all
    Activity.delete_all
    Amenity.delete_all
    SiteType.delete_all
  end

  def import_campgrounds
    response = self.class.get("/campgrounds?pstate=CO")
    parsed_body = response.parsed_response
    campground_results = Array.wrap(parsed_body['resultset']['result'])
    campground_results.map do |result|
      campsite = Campsite.where(name: result['facilityName']).first_or_initialize
      campsite.assign_attributes(
        latitude: result['latitude'],
        longitude: result['longitude'],
        external_facility_id: result['facilityID'],
        contract_code: result['contractID']
      )
      campsite.save!

      amenity_types = {
        'sitesWithAmps' => 'Electricity Hookups',
        'sitesWithPetsAllowed' => 'Pets Allowed',
        'siteWithSewerHookup' => 'Sewer Hookup',
        'sitesWithWaterfront' => 'Waterfront',
        'sitesWithWaterHookup' => 'Water Hookup'
      }
      amenity_types.each do |amenity_type, amenity_name|
        amenity = Amenity.where(name: amenity_name).first_or_create!
        if result[amenity_type] == "Y"
          campsite.amenities << amenity
        end
      end

      campsite
    end
  end

  def import_campground_details(campsite)
    response = self.class.get("/campground/details?contractCode=#{campsite.contract_code}&parkId=#{campsite.external_facility_id}")
    body = response.body
    body.gsub!(%r!<photo realUrl="([^"]+)"[^>]+/>!, '<photo realUrl="\1"/>')
    parsed_body = MultiXml.parse(body)
    result = parsed_body['detailDescription']

    campsite.description = result['description'].squish

    campsite.reservation_url = result['fullReservationUrl']

    address = result['address']
    campsite.street_address = address['streetAddress']
    campsite.city = address['city']
    campsite.state = address['state']
    campsite.zip = address['zip']

    campsite.photo_urls = result['photo'].map do |photo|
      url = photo['realUrl']
      if url =~ %r{^/}
        url = "http://reserveamerica.com#{url}"
      end
      url
    end

    phone_number = result['contact'][0]['number']
    if phone_number.blank?
      phone_number = result['contact'][1]['number']
    end
    campsite.phone_number = phone_number

    campsite.save!

    activities = result['amenity']
    activities.each do |activity|
      activity_name = activity['name'].gsub('&amp;', '&')
      activity = Activity.where(name: activity_name).first_or_create!
      campsite.activities << activity
    end
  end

  def import_campsites(campsite)
    site_type_names_by_id = {
      '2001' => 'RV Sites',
      '10001' => 'Cabins or Lodgings',
      '2003' => 'Tent',
      '2002' => 'Trailer',
      '9002' => 'Group Site',
      '9001' => 'Day Use',
      '3001' => 'Horse Site',
      '2004' => 'Boat Site'
    }
    site_type_names_by_id.each do |site_type, site_type_name|
      response = self.class.get("/campsites?contractCode=#{campsite.contract_code}&parkId=#{campsite.external_facility_id}&siteType=#{site_type}")
      parsed_body = response.parsed_response
      resultset = parsed_body['resultset']
      if resultset['result']
        site_type = SiteType.where(name: site_type_name).first_or_create!
        campsite.site_types << site_type
      end
    end
  end
end
