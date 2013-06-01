require 'spec_helper'

feature 'Search by activity' do
  scenario 'Search form has a dropdown with all activities' do
    create(:activity, name: 'Fishing')
    create(:activity, name: 'Hiking')

    visit root_url

    expect(page).to have_select("It'd be fun to go", options: %w(Fishing Hiking))
  end

  scenario 'Users can search by activity'
end
