class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|
      t.string :name
      t.belongs_to :campsite

      t.timestamps
    end
    add_index :amenities, :campsite_id
  end
end
