# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121004220950) do

  create_table "alternatives", :force => true do |t|
    t.integer "experiment_id"
    t.string  "content"
    t.string  "lookup",        :limit => 32
    t.integer "weight",                      :default => 1
    t.integer "participants",                :default => 0
    t.integer "conversions",                 :default => 0
  end

  add_index "alternatives", ["experiment_id"], :name => "index_alternatives_on_experiment_id"
  add_index "alternatives", ["lookup"], :name => "index_alternatives_on_lookup"

  create_table "choice_choices", :force => true do |t|
    t.integer "choice_id",         :null => false
    t.integer "related_choice_id"
  end

  add_index "choice_choices", ["choice_id", "related_choice_id"], :name => "index_choice_choices_on_choice_id_and_related_choice_id", :unique => true
  add_index "choice_choices", ["choice_id"], :name => "index_choice_choices_on_choice_id", :unique => true
  add_index "choice_choices", ["related_choice_id"], :name => "index_choice_choices_on_related_choice_id"

  create_table "clicks", :force => true do |t|
    t.integer  "user_id"
    t.string   "controller"
    t.string   "action"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referrer"
    t.integer  "session_info_id"
  end

  add_index "clicks", ["session_info_id"], :name => "index_clicks_on_session_info_id"

  create_table "consultations", :force => true do |t|
    t.string   "name",                          :null => false
    t.boolean  "active",     :default => false, :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "earls", :force => true do |t|
    t.string   "name"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "active",                           :default => true
    t.string   "pass"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "welcome_message",   :limit => 400
    t.string   "default_lang",                     :default => "en"
    t.string   "logo_size",                        :default => "medium"
    t.boolean  "flag_enabled",                     :default => false
    t.boolean  "photocracy",                       :default => false
    t.string   "ga_code"
    t.integer  "consultation_id"
  end

  add_index "earls", ["consultation_id"], :name => "index_earls_on_consultation_id"
  add_index "earls", ["question_id"], :name => "index_earls_on_question_id"

  create_table "experiments", :force => true do |t|
    t.string   "test_name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experiments", ["test_name"], :name => "index_experiments_on_test_name"

  create_table "exports", :force => true do |t|
    t.binary   "data",       :limit => 2147483647
    t.string   "name",                             :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "compressed",                       :default => false
  end

  add_index "exports", ["name"], :name => "index_exports_on_name"

  create_table "photos", :force => true do |t|
    t.string   "image_file_name",    :default => ""
    t.string   "image_content_type", :default => ""
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rotation",           :default => 0
    t.string   "original_file_name"
  end

  create_table "session_infos", :force => true do |t|
    t.string   "session_id"
    t.string   "ip_addr"
    t.string   "user_agent"
    t.string   "loc_info",            :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "white_label_request"
    t.integer  "visitor_id"
    t.integer  "user_id"
    t.string   "loc_info_2",          :default => ""
  end

  add_index "session_infos", ["session_id"], :name => "index_session_infos_on_session_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "trials", :force => true do |t|
    t.integer  "session_info_id"
    t.integer  "alternative_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",   :limit => 128
    t.string   "salt",                 :limit => 128
    t.string   "confirmation_token",   :limit => 128
    t.string   "remember_token",       :limit => 128
    t.boolean  "email_confirmed",                     :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default",                             :default => false
    t.boolean  "admin",                               :default => false
    t.integer  "facebook_id",          :limit => 8
    t.string   "facebook_oauth_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"
  add_index "users", ["id", "confirmation_token"], :name => "index_users_on_id_and_confirmation_token"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "visitors", :force => true do |t|
    t.string   "remember_token", :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visitors", ["remember_token"], :name => "index_visitors_on_remember_token"

end
