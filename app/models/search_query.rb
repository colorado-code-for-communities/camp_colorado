class SearchQuery
  def initialize(amenity_ids, site_type)
    @amenity_ids = amenity_ids
    @site_type = site_type
  end

  def build
    reset_campsites
    filter_site_type
    filter_amenities
    campsites
  end

  private

  def reset_campsites
    self.campsites = Campsite.includes(:amenities)
  end

  def filter_site_type
    self.campsites = campsites.where(site_type: site_type)
  end

  def filter_amenities
    campsites.reject! do |campsite|
      (amenity_ids - campsite.amenity_ids).any?
    end
  end

  attr_reader :amenity_ids, :site_type
  attr_accessor :campsites
end
