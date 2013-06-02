class AddFieldsToCampsite < ActiveRecord::Migration

  def up
    change_table :campsites do |t|
      t.remove :address
      t.integer :external_facility_id
      t.string :city
      t.string :state
      t.string :zip
      t.string :street_address
      t.string :contract_code
      t.string :photo_urls
      t.text :description
    end
  end

  def down
    change_table :campsites do |t|
      t.string :address
      t.remove :external_facility_id
      t.remove :city
      t.remove :state
      t.remove :zip
      t.remove :street_address
      t.remove :contract_code
      t.remove :photo_urls
      t.remove :description
    end
  end
end
