require 'spec_helper'

describe SearchQuery do
  it 'returns campsites filtered by amenities' do
    amenity = create(:amenity)
    campsite = create(:campsite, amenities: [amenity])
    second_campsite = create(:campsite)

    campsites = SearchQuery.new([amenity.id], campsite.site_type).build

    expect(campsites).to include(campsite)
    expect(campsites).not_to include(second_campsite)
  end

  it 'returns campsites filtered by site type' do
    diabetes_camp = create(:campsite, site_type: 'Diabetes')
    fat_camp = create(:campsite, site_type: 'Fat kid')

    campsites = SearchQuery.new([], 'Diabetes').build

    expect(campsites).to include(diabetes_camp)
    expect(campsites).not_to include(fat_camp)
  end
end
