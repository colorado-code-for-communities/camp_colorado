require 'spec_helper'

feature 'Search by site type' do
  include SearchHelpers

  scenario 'Search form has a dropdown with all site types' do
    tent_site = create(:campsite, site_type: 'Tent Site')
    rv_site = create(:campsite, site_type: 'RV Site')

    visit root_url

    expect(page).to have_select("I'm looking for", options: ['Tent Site', 'RV Site'])
  end

  scenario 'Users can search by site type' do
    tent_site = create(:campsite, site_type: 'Tent Site')
    rv_site = create(:campsite, site_type: 'RV Site')

    search_for_site_type('Tent Site')

    expect(search_results).to include(tent_site)
    expect(search_results).not_to include(rv_site)
  end
end
