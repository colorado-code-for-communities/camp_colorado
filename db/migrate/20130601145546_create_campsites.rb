class CreateCampsites < ActiveRecord::Migration
  def change
    create_table :campsites do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.date :open_date
      t.date :close_date
      t.string :phone_number
      t.string :website
      t.string :reservation_url

      t.timestamps
    end
  end
end
