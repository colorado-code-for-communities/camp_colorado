module CampsiteHelper
  def campsite_overview(campsite)
    (campsite.amenities + campsite.activities).take(5).map(&:name)
  end
end
