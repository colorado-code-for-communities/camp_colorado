require 'spec_helper'

describe SearchQuery do
  it 'returns campsites filtered by amenities' do
    amenity = create(:amenity)
    campsite = create(:campsite, amenities: [amenity])
    second_campsite = create(:campsite)

    campsites = SearchQuery.new(campsite.site_type_ids, [], [amenity.id]).build

    expect(campsites).to include(campsite)
    expect(campsites).not_to include(second_campsite)
  end

  it 'returns campsites filtered by site type' do
    tent_type = create(:site_type, name: 'Tent Site')
    rv_type = create(:site_type, name: 'RV Site')
    tent_camp = create(:campsite, site_types: [tent_type])
    rv_camp = create(:campsite, site_types: [rv_type])

    campsites = SearchQuery.new([tent_type.id], [], []).build

    expect(campsites).to include(tent_camp)
    expect(campsites).not_to include(rv_camp)
  end

  it 'returns campsites filtered by activities' do
    fishing = create(:activity, name: 'Fishing')
    hiking = create(:activity, name: 'Hiking')
    mountain_camp = create(:campsite, activities: [fishing, hiking])
    lakeside_camp = create(:campsite, activities: [fishing])

    campsites = SearchQuery.new(mountain_camp.site_type_ids, [fishing.id, hiking.id], []).build

    expect(campsites).to include(mountain_camp)
    expect(campsites).not_to include(lakeside_camp)
  end
end
