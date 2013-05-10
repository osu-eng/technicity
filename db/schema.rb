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

ActiveRecord::Schema.define(:version => 20130508150435) do

  create_table "comparisons", :force => true do |t|
    t.integer  "chosen_location_id"
    t.integer  "rejected_location_id"
    t.string   "voter_remote_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.integer  "study_id"
    t.string   "voter_session_id"
    t.decimal  "voter_latitude",       :precision => 15, :scale => 12
    t.decimal  "voter_longitude",      :precision => 15, :scale => 12
  end

  create_table "locations", :force => true do |t|
    t.integer  "region_id"
    t.integer  "heading"
    t.integer  "pitch"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.decimal  "latitude",   :precision => 15, :scale => 12
    t.decimal  "longitude",  :precision => 15, :scale => 12
  end

  create_table "notifications", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "region_set_memberships", :force => true do |t|
    t.integer  "region_set_id"
    t.integer  "region_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "region_sets", :force => true do |t|
    t.integer  "user_id"
    t.string   "slug"
    t.string   "name"
    t.boolean  "public"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.boolean  "locked"
  end

  create_table "regions", :force => true do |t|
    t.integer  "user_id"
    t.string   "slug"
    t.string   "name"
    t.boolean  "public"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.text     "polygon"
    t.text     "description"
    t.integer  "zoom"
    t.decimal  "latitude",    :precision => 15, :scale => 12
    t.decimal  "longitude",   :precision => 15, :scale => 12
    t.boolean  "locked"
  end

  add_index "regions", ["slug"], :name => "index_regions_on_slug", :unique => true

  create_table "studies", :force => true do |t|
    t.string   "slug"
    t.string   "question"
    t.boolean  "public",        :default => true
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "region_set_id"
    t.string   "name"
    t.integer  "user_id"
    t.text     "description"
    t.boolean  "active"
    t.datetime "opened_at"
    t.datetime "closed_at"
    t.boolean  "promoted",      :default => false
  end

  add_index "studies", ["slug"], :name => "index_studies_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "coursera_id"
    t.boolean  "admin",                  :default => false
    t.boolean  "blocked",                :default => false
  end

end
