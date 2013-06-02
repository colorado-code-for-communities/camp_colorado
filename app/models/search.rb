class Search
  include Enumerable

  delegate :each, to: :results

  attr_reader :results

  def initialize(options = {})
    @amenity_ids = options.fetch(:amenity_ids) { [] }
    @activity_ids = options.fetch(:activity_ids) { [] }
    @site_type_ids = options.fetch(:site_type_ids) { [] }
    @performed = false
  end

  def performed?
    @performed
  end

  def perform!
    @results = SearchQuery.new(site_type_ids, activity_ids, amenity_ids).build
    @performed = true
  end

  def possible_site_types
    Campsite.uniq.pluck(:site_type)
  end

  def query_items
    SiteType.find(site_type_ids) + Activity.find(activity_ids) + Amenity.find(amenity_ids)
  end

  private

  attr_reader :site_type

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
