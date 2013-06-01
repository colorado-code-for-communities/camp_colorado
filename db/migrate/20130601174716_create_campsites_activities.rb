class CreateCampsitesActivities < ActiveRecord::Migration
  def change
    create_table :campsites_activities do |t|
      t.belongs_to :campsite
      t.belongs_to :activity

      t.timestamps
    end
    add_index :campsites_activities, :campsite_id
    add_index :campsites_activities, :activity_id
  end
end
