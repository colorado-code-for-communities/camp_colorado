class Search
  include Enumerable

  delegate :each, to: :results

  def initialize(options = {})
    @amenity_ids = options.fetch(:amenity_ids) { [] }
    @activity_ids = options.fetch(:activity_ids) { [] }
    @site_type_ids = options.fetch(:site_type_ids) { [] }
  end

  def possible_site_types
    Campsite.uniq.pluck(:site_type)
  end

  private

  attr_reader :site_type

  def results
    @results ||= SearchQuery.new(site_type_ids, activity_ids, amenity_ids).build
  end

  def site_type_ids
    sanitize_ids(@site_type_ids)
  end

  def amenity_ids
    sanitize_ids(@amenity_ids)
  end

  def activity_ids
    sanitize_ids(@activity_ids)
  end

  def sanitize_ids(ids)
    ids.select(&:present?).map(&:to_i)
  end

  # ActiveModel boilerplate
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end
end
