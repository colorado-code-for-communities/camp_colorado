class SearchQuery
  def initialize(site_type_ids, activity_ids, amenity_ids)
    @site_type_ids = site_type_ids
    @activity_ids = activity_ids
    @amenity_ids = amenity_ids
  end

  def build
    reset_campsites
    filter_site_type
    filter_activities
    filter_amenities
    campsites
  end

  private

  def reset_campsites
    self.campsites = Campsite.includes(:amenities)
  end

  def filter_site_type
    filter_by(:site_type_ids)
  end

  def filter_activities
    filter_by(:activity_ids)
  end

  def filter_amenities
    filter_by(:amenity_ids)
  end

  def filter_by(macro)
    campsites.reject! do |campsite|
      (send(macro) - campsite.send(macro)).any?
    end
  end

  attr_reader :amenity_ids, :site_type_ids, :activity_ids
  attr_accessor :campsites
end
