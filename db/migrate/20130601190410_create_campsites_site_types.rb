class CreateCampsitesSiteTypes < ActiveRecord::Migration
  def change
    create_table :campsites_site_types do |t|
      t.belongs_to :campsite
      t.belongs_to :site_type

      t.timestamps
    end
    add_index :campsites_site_types, :campsite_id
    add_index :campsites_site_types, :site_type_id
  end
end
