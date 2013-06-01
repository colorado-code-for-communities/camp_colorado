require 'httparty'
require 'pp'
require 'ostruct'

class CampsiteParser
  CAMPSITE = 'http://api.amp.active.com/camping/campgrounds'
  CAMPSITE_API_KEY = ENV['CAMPSITE_API_KEY']

  def campgrounds
    campgrounds_hash = HTTParty.get("#{CAMPSITE}?pstate=CO&api_key=#{CAMPSITE_API_KEY}").parsed_response['resultset']['result']

    campgrounds_hash.map do |campground_hash|
      Campsite.new(
        latitude: campground_hash['latitude'],
        longitude: campground_hash['longitude'],
        name: campground_hash['facilityName'],
        address: 'none'
      )
    end
  end
end
