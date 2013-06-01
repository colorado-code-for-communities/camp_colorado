class Search
  include Enumerable

  delegate :each, to: :results

  def initialize(options = {})
    @amenity_ids = options.fetch(:amenity_ids) { [] }
    @site_type = options[:site_type].to_s
  end

  def possible_site_types
    Campsite.uniq.pluck(:site_type)
  end

  private

  attr_reader :site_type

  def results
    @results ||= SearchQuery.new(amenity_ids, site_type).build
  end

  def amenity_ids
    @amenity_ids.select(&:present?).map(&:to_i)
  end

  def activity_ids
  end

  # ActiveModel boilerplate
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end
end
