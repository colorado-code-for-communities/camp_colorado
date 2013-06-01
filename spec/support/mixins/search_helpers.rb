module SearchHelpers
  def search_for_amenity(amenity_name)
    visit root_url
    select amenity_name, from: 'accomodations'
    click_on 'Submit'
  end

  def search_results
    Campsite.where(name: all('.campsite-name').map(&:text))
  end
end
