require 'httparty'
require 'pp'
require 'ostruct'

class CampsiteImporter
  CAMPGROUNDS = 'http://api.amp.active.com/camping/campgrounds'
  CAMPSITE = 'http://api.amp.active.com/camping/campsite'

  def initialize(api_key)
    @api_key = api_key
  end

  def import
    response = HTTParty.get("#{CAMPGROUNDS}?pstate=CO&api_key=#{@api_key}")
    campground_results = response.parsed_response['resultset']['result']
    campground_results.each do |result|
      campsite = Campsite.where(name: result['facilityName']).first_or_initialize
      campsite.assign_attributes(
        latitude: result['latitude'],
        longitude: result['longitude']
      )
      campsite.save!
    end
  end
end
