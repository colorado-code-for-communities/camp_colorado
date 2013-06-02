class ExtendCampsitesPhotoUrlsToText < ActiveRecord::Migration
  def up
    change_table :campsites do |t|
      t.change :photo_urls, :text
    end
  end

  def down
    change_table :campsites do |t|
      t.change :photo_urls, :string
    end
  end
end
