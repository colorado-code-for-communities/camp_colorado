# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130602013159) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "amenities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "amenities_campsites", :force => true do |t|
    t.integer  "campsite_id"
    t.integer  "amenity_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "amenities_campsites", ["amenity_id"], :name => "index_amenities_campsites_on_amenity_id"
  add_index "amenities_campsites", ["campsite_id"], :name => "index_amenities_campsites_on_campsite_id"

  create_table "campsites", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.date     "open_date"
    t.date     "close_date"
    t.string   "phone_number"
    t.string   "website"
    t.string   "reservation_url"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "external_facility_id"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "street_address"
    t.string   "contract_code"
    t.text     "photo_urls"
    t.text     "description"
  end

  create_table "campsites_activities", :force => true do |t|
    t.integer  "campsite_id"
    t.integer  "activity_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "campsites_activities", ["activity_id"], :name => "index_campsites_activities_on_activity_id"
  add_index "campsites_activities", ["campsite_id"], :name => "index_campsites_activities_on_campsite_id"

  create_table "campsites_site_types", :force => true do |t|
    t.integer  "campsite_id"
    t.integer  "site_type_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "campsites_site_types", ["campsite_id"], :name => "index_campsites_site_types_on_campsite_id"
  add_index "campsites_site_types", ["site_type_id"], :name => "index_campsites_site_types_on_site_type_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "site_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
