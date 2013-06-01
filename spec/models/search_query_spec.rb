require 'spec_helper'

describe SearchQuery do
  it 'returns campsites filtered by amenities' do
    amenity = create(:amenity)
    campsite = create(:campsite, amenities: [amenity])
    second_campsite = create(:campsite)

    campsites = SearchQuery.new(campsite.site_type, [], [amenity.id]).build

    expect(campsites).to include(campsite)
    expect(campsites).not_to include(second_campsite)
  end

  it 'returns campsites filtered by site type' do
    diabetes_camp = create(:campsite, site_type: 'Diabetes')
    fat_camp = create(:campsite, site_type: 'Fat kid')

    campsites = SearchQuery.new('Diabetes', [], []).build

    expect(campsites).to include(diabetes_camp)
    expect(campsites).not_to include(fat_camp)
  end

  it 'returns campsites filtered by activities' do
    fishing = create(:activity, name: 'Fishing')
    hiking = create(:activity, name: 'Hiking')
    mountain_camp = create(:campsite, activities: [fishing, hiking])
    lakeside_camp = create(:campsite, activities: [fishing])

    campsites = SearchQuery.new(mountain_camp.site_type, [fishing.id, hiking.id], []).build

    expect(campsites).to include(mountain_camp)
    expect(campsites).not_to include(lakeside_camp)
  end
end
