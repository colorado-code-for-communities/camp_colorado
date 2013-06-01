class Amenity < ActiveRecord::Base
  has_many :amenities_campsites
  has_many :campsites, through: :amenities_campsites
  attr_accessible :name

  validates :name, presence: true
end
