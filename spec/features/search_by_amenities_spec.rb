require 'spec_helper'
include SearchHelpers

feature 'Search by amenities' do
  scenario 'A user can search for a campsite with an amenity', js: true do
    pets_allowed = create(:amenity, name: 'Pets Allowed')
    fun_campsite = create(:campsite, amenities: [pets_allowed])
    nazi_campsite = create(:campsite)

    search_for_amenity('Pets Allowed')

    expect(search_results).to include(fun_campsite)
    expect(search_results).not_to include(nazi_campsite)
  end
end
