class CampsitesSiteType < ActiveRecord::Base
  belongs_to :campsite
  belongs_to :site_type
end
