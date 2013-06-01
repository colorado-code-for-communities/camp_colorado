class Campsite < ActiveRecord::Base
  attr_accessible :address, :close_date, :latitude, :longitude, :name, :open_date, :phone_number, :reservation_url, :website

  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
end
