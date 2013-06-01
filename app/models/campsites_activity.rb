class CampsitesActivity < ActiveRecord::Base
  belongs_to :campsite
  belongs_to :activity
end
