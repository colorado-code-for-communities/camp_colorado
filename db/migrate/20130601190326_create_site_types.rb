class CreateSiteTypes < ActiveRecord::Migration
  def change
    create_table :site_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
