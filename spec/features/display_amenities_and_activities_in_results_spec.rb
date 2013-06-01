require 'spec_helper'

feature "Display amenities and activities in results spec", js: true do
  include SearchHelpers
  scenario "A user can see amenities and activities for a campsite" do
    fishing = create(:activity, name: 'Fishing')
    pets_allowed = create(:amenity, name: 'Pets Allowed')
    electricity = create(:amenity, name: 'Electricity')
    campsite = create(:campsite, amenities: [pets_allowed], activities: [fishing])

    search_for_activity('Fishing')

    expect(shown_amenities_for(campsite)).to include('Fishing')
    expect(shown_amenities_for(campsite)).to include('Pets Allowed')
    expect(shown_amenities_for(campsite)).not_to include('Electricity')
  end

  scenario "Only 5 amenities are displayed"
  scenario "Amenities are displayed before activities"
end
