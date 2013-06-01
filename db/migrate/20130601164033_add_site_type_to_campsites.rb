class AddSiteTypeToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :site_type, :string
  end
end
