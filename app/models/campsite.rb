class Campsite < ActiveRecord::Base
  attr_accessible :address, :close_date, :latitude, :longitude, :name, :open_date, :phone_number, :reservation_url, :website, :site_type, :amenity_ids

  has_many :amenities_campsites
  has_many :amenities, through: :amenities_campsites

  has_many :campsites_activities
  has_many :activities, through: :campsites_activities

  has_many :campsites_site_types
  has_many :site_types, through: :campsites_site_types

  validates :address, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :name, presence: true
end
