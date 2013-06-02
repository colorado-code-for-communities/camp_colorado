module CampsiteHelper
  def campsite_overview(campsite)
    (campsite.amenities + campsite.activities).take(5).map(&:name)
  end

  def static_map_url(campsite)
    "http://maps.googleapis.com/maps/api/staticmap" <<
    "?center=#{campsite.latitude},#{campsite.longitude}" <<
    "&zoom=11&size=304x190" <<
    "&markers=#{campsite.latitude},#{campsite.longitude}" <<
    "&key=#{ENV['GOOGLE_API_KEY']}" <<
    "&sensor=false"
  end
end
