class Campsite < ActiveRecord::Base
  attr_accessible \
    :activity_ids,
    :amenity_ids,
    :city,
    :close_date,
    :contract_code,
    :description,
    :external_facility_id,
    :latitude,
    :longitude,
    :name,
    :open_date,
    :phone_number,
    :photo_urls,
    :reservation_url,
    :site_type,
    :state,
    :street_address,
    :website,
    :zip

  has_many :amenities_campsites
  has_many :amenities, through: :amenities_campsites

  has_many :campsites_activities
  has_many :activities, through: :campsites_activities

  has_many :campsites_site_types
  has_many :site_types, through: :campsites_site_types

  validates :latitude, presence: true, numericality: true, allow_blank: true
  validates :longitude, presence: true, numericality: true, allow_blank: true
  validates :name, presence: true

  serialize :photo_urls, JSON

  def city_state_zip
    if zip.present?
      "#{city} #{state}, #{zip}"
    else
      "#{city} #{state}"
    end
  end

  def photo_urls
    super.select(&:present?)
  end
end
