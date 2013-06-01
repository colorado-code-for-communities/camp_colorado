require 'spec_helper'

feature "Query icons", js: true do
  include SearchHelpers

  scenario "Query items are displayed for a search" do
    fishing = create(:activity, name: 'Fishing')
    river_rafting = create(:activity, name: 'River Rafting')

    search_for_activity('River Rafting')

    expect(displayed_query_icons).to include('river-rafting')
    expect(displayed_query_icons).not_to include('fishing')
  end
  scenario "Clicking a query item removes it"
end
