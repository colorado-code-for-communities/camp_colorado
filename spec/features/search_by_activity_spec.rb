require 'spec_helper'

feature 'Search by activity' do
  include SearchHelpers

  scenario 'Search form has a dropdown with all activities' do
    create(:activity, name: 'Fishing')
    create(:activity, name: 'Hiking')

    visit root_url

    expect(page).to have_select("It'd be fun to go", options: %w(Fishing Hiking))
  end

  scenario 'Users can search by activity', js: true do
    fishing = create(:activity, name: 'Fishing')
    lakeside_campsite = create(:campsite, activities: [fishing])
    desert_campsite = create(:campsite)

    search_for_activity('Fishing')

    expect(search_results).to include(lakeside_campsite)
    expect(search_results).not_to include(desert_campsite)
  end
end
