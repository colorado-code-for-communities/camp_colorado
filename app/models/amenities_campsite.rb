class AmenitiesCampsite < ActiveRecord::Base
  belongs_to :campsite
  belongs_to :amenity
end
