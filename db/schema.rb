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

ActiveRecord::Schema.define(:version => 20131230014446) do

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

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "locations", :force => true do |t|
    t.integer  "region_id"
    t.integer  "heading"
    t.integer  "pitch"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.decimal  "latitude",   :precision => 15, :scale => 12
    t.decimal  "longitude",  :precision => 15, :scale => 12
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
    t.boolean  "public",                :default => true
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "region_set_id"
    t.string   "name"
    t.integer  "user_id"
    t.text     "description"
    t.boolean  "active"
    t.datetime "opened_at"
    t.datetime "closed_at"
    t.boolean  "promoted",              :default => false
    t.integer  "comparisons_count",     :default => 0
    t.integer  "survey_id"
    t.integer  "survey_required_votes"
    t.boolean  "has_survey",            :default => false
    t.boolean  "limit_votes",           :default => false
  end

  add_index "studies", ["slug"], :name => "index_studies_on_slug", :unique => true
  add_index "studies", ["survey_id"], :name => "index_studies_on_survey_id"

  create_table "survey_options", :force => true do |t|
    t.integer  "survey_question_id"
    t.string   "option"
    t.integer  "order_by"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "survey_options", ["survey_question_id"], :name => "index_survey_options_on_survey_question_id"

  create_table "survey_questions", :force => true do |t|
    t.integer  "survey_id"
    t.string   "question"
    t.text     "description"
    t.boolean  "multiple_choice", :default => false
    t.integer  "order_by"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "survey_questions", ["survey_id"], :name => "index_survey_questions_on_survey_id"

  create_table "survey_responses", :force => true do |t|
    t.integer  "survey_question_id"
    t.integer  "survey_option_id"
    t.integer  "study_id"
    t.string   "voter_session_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "survey_responses", ["study_id"], :name => "index_survey_responses_on_study_id"
  add_index "survey_responses", ["survey_option_id"], :name => "index_survey_responses_on_survey_option_id"
  add_index "survey_responses", ["survey_question_id"], :name => "index_survey_responses_on_survey_question_id"

  create_table "surveys", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

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

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
