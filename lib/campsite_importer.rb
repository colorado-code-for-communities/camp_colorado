require 'httparty'
require 'pp'
require 'ostruct'

class CampsiteImporter
  include HTTParty

  base_uri 'http://api.amp.active.com/camping'

  def initialize(api_key, output: $stdout)
    self.class.default_params('api_key' => api_key)
    @output = output
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
    @output.puts "=== Importing campgrounds ==="

    response = fetch(:campgrounds, "/campgrounds?pstate=CO")
    parsed_body = response.parsed_response
    campground_results = Array.wrap(parsed_body['resultset']['result'])
    imported_campsites = []
    campground_results.each do |result|
      @output.puts "Importing campground: #{result['facilityName']}"
      name = result['facilityName'].strip
      campsite = Campsite.where(name: name).first_or_initialize
      campsite.assign_attributes(
        latitude: result['latitude'],
        longitude: result['longitude'],
        external_facility_id: result['facilityID'],
        contract_code: result['contractID']
      )
      if campsite.save
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
        imported_campsites << campsite
      else
        @output.puts "-> Couldn't save: #{campsite.errors.full_messages}"
      end
    end

    @output.puts

    imported_campsites
  end

  def import_campground_details(campsite)
    @output.puts "=== Importing campground details for: #{campsite.name} ==="

    response = fetch(
      :"campground_details_for_#{campsite.external_facility_id}",
      "/campground/details?contractCode=#{campsite.contract_code}&parkId=#{campsite.external_facility_id}"
    )
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

    campsite.photo_urls = Array.wrap(result['photo']).map do |photo|
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

    activities = Array.wrap(result['amenity'])
    activities.each do |activity|
      activity_name = activity['name'].gsub('&amp;', '&')
      if activity_name.present?
        if known_amenities.include?(activity_name)
          amenity = Amenity.where(name: activity_name).first_or_create!
          campsite.amenities << amenity
        else
          activity = Activity.where(name: activity_name).first_or_create!
          campsite.activities << activity
        end
      end
    end

    @output.puts

  rescue => e
    @output.puts "Response body: #{response.body}"
    raise e
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
      @output.puts "=== Importing campsites for: #{campsite.name} / #{site_type_name} ==="
      begin
        response = fetch(
          :"campsites_for_#{campsite.external_facility_id}_#{site_type}",
          "/campsites?contractCode=#{campsite.contract_code}&parkId=#{campsite.external_facility_id}&siteType=#{site_type}"
        )
        parsed_body = response.parsed_response
        if parsed_body
          resultset = parsed_body['resultset']
          if resultset['result']
            site_type = SiteType.where(name: site_type_name).first_or_create!
            campsite.site_types << site_type
          end
        end
      rescue => e
        @output.puts "Response body: #{response.body}"
        raise e
      end
    end

    @output.puts
  end

  def known_amenities
    [
      "ADA Access", "ADA Fish. Access", "ADA Fishing Pier", "ATV Rentals",
      "Accessible Boat Dock", "Accessible Boat Ramp", "Accessible Campsites",
      "Accessible Drinking Water", "Accessible Fishing Dock", "Accessible Grills",
      "Accessible Group Shelters", "Accessible Hiking Trails",
      "Accessible Parking", "Accessible Picnic Area", "Accessible Picnic Areas",
      "Accessible Picnic Shelters", "Accessible Pit Toilets", "Accessible Scenic Overlook", "Accessible Showers", "Accessible Site ", "Accessible Sites",
      "Accessible Trails", "Accessible Vault Toilet", "Accessible Vault Toilets ",
      "Bait Shop", "Cell phone service", "Church", "Churches", "Cleaning Supplies",
      "Cafe", "Cash Machine/Atm", "Catering", "Flush Toilet", "Flush Toilets",
      "Flush Toilets (Seasonal)", "Food Concessions", "Food Storage Locker",
      "Fuel Available", "Fuel, Vehicles", "Ice", "Ice Fishing", "Ice Machine",
      "Ice Sales", "Laundry", "Laundry Facilities", "Laundry Facilities (May 1st - September 30th)",
      "Mattress(es)", "Electric Hook Ups", "Electric Hook-Up", "Electric Hookups",
      "Electric Stove", "Electricity", "Emergency Phone", "Emergency Services",
      "Equestrian Sites", "Fee Station", "Fire Extinguisher", "Fire Rings",
      "Fireplace", "Firewood", "Firewood Available", "Firewood Sales",
      "Firewood Vendor", "First Aid Kit", "First Aid Station", "Fish Cleaning Station",
      "Fish Cleaning Stations", "Table & Chairs", "Table and Chairs", "Tables",
      "Telephone"
    ]
  end

  def fetch(cassette_name, url)
    possibly_wrap_with_vcr(cassette_name) { self.class.get(url) }
  end

  def possibly_wrap_with_vcr(cassette_name, &block)
    if defined?(VCR)
      ret = nil
      VCR.use_cassette(cassette_name, tag: :active_api) do
        ret = block.call
      end
      ret
    else
      # Sleep because the active.com API has a rate limit of 2 requests/second
      sleep 0.5
      block.call
    end
  end
end
