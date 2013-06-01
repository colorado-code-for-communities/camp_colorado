module SearchHelper
  def icon_for(query_item)
    query_item.name.downcase.gsub(' ', '-')
  end
end
