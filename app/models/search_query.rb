class SearchQuery
  def initialize(amenity_ids)
    @amenity_ids = amenity_ids
  end

  def build
    reset_campsites
    filter_amenities
    campsites
  end

  private

  def filter_amenities
    campsites.reject! do |campsite|
      (amenity_ids - campsite.amenity_ids).any?
    end
  end

  def reset_campsites
    self.campsites = Campsite.includes(:amenities)
  end

  attr_reader :amenity_ids
  attr_accessor :campsites
end
