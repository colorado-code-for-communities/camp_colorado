module SearchHelpers
  def search_for_amenity(amenity_name)
    search_by(amenity_name, 'accomodations')
  end

  def search_for_site_type(site_type)
    search_by(site_type, "I'm looking for")
  end

  def search_for_activity(activity_name)
    search_by(activity_name, "It'd be fun to go")
  end

  def search_by(value, selector)
    visit root_url
    select value, from: selector
  end

  def search_results
    Campsite.where(name: all('.campsite-name').map(&:text))
  end
end
