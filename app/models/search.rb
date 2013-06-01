class Search
  include Enumerable

  delegate :each, to: :results

  def initialize(options = {})
    @amenity_ids = options.fetch(:amenity_ids) { [] }
  end

  def results
    @results ||= SearchQuery.new(amenity_ids).build
  end

  def amenity_ids
    @amenity_ids.select(&:present?).map(&:to_i)
  end

  # ActiveModel boilerplate
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end
end
