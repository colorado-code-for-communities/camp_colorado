require 'spec_helper'

describe SearchQuery do
  it 'returns campsites filtered by amenities' do
    amenity = create(:amenity)
    campsite = create(:campsite, amenities: [amenity])
    second_campsite = create(:campsite)

    campsites = SearchQuery.new([amenity.id]).build

    expect(campsites).to include(campsite)
    expect(campsites).not_to include(second_campsite)
  end
end
