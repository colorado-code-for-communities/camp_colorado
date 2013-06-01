class CreateAmenitiesCampsites < ActiveRecord::Migration
  def change
    create_table :amenities_campsites do |t|
      t.belongs_to :campsite
      t.belongs_to :amenity

      t.timestamps
    end
    add_index :amenities_campsites, :campsite_id
    add_index :amenities_campsites, :amenity_id

    remove_column :amenities, :campsite_id
  end
end
