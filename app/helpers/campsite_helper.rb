module CampsiteHelper
  def campsite_overview(campsite)
    (campsite.activities + campsite.amenities).map(&:name)
  end
end
