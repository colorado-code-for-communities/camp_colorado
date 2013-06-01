class Campsite < ActiveRecord::Base
  attr_accessible :address, :close_date, :latitude, :longitude, :name, :open_date, :phone_number, :reservation_url, :website, :site_type

  has_many :amenities_campsites
  has_many :amenities, through: :amenities_campsites

  validates :address, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :name, presence: true
  validates :site_type, presence: true
end
