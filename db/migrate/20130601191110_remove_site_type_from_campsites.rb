class RemoveSiteTypeFromCampsites < ActiveRecord::Migration
  def up
    Campsite.all.each do |campsite|
      site_type = SiteType.where(name: campsite.site_type).first_or_create!
      campsite.site_types = [site_type]
      campsite.save!
    end

    remove_column :campsites, :site_type
  end

  def down
    add_column :campsites, :site_type, :string
    Campsite.all.each do |campsite|
      campsite.site_type = campsite.site_types.first.name
      campsite.save!
    end
  end
end
