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

  scenario "Only 5 amenities are displayed" do
    6.times { |n| create(:amenity, name: "Amenity #{n}") }
    campsite = create(:campsite, amenities: Amenity.all)

    search_for_amenity('Amenity 1')

    expect(shown_amenities_for(campsite)).not_to include('Amenity 5')
  end

  scenario "Amenities are displayed before activities" do
    5.times { |n| create(:amenity, name: "Amenity #{n}") }
    fishing = create(:activity, name: 'Fishing')
    campsite = create(:campsite, amenities: Amenity.all, activities: [fishing])

    search_for_activity('Fishing')

    expect(shown_amenities_for(campsite)).not_to include('Fishing')
  end
end
