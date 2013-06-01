class Campsite < ActiveRecord::Base
  attr_accessible \
    :amenity_ids,
    :close_date,
    :contract_code,
    :external_facility_id,
    :latitude,
    :longitude,
    :name,
    :open_date,
    :phone_number,
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

  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :name, presence: true
  validates :site_type, presence: true
end
