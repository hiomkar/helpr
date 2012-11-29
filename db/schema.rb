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

ActiveRecord::Schema.define(:version => 20121129032831) do

  create_table "admins", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
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
    t.integer  "business_id"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "agents", :force => true do |t|
    t.integer  "business_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
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
  end

  add_index "agents", ["email"], :name => "index_agents_on_email", :unique => true
  add_index "agents", ["reset_password_token"], :name => "index_agents_on_reset_password_token", :unique => true

  create_table "businesses", :force => true do |t|
    t.string   "biz_name"
    t.string   "biz_url"
    t.time     "start_hour"
    t.time     "end_hour"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "chat_users", :force => true do |t|
    t.string   "first_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "chats", :force => true do |t|
    t.integer  "business_id"
    t.integer  "customer_id"
    t.string   "channel"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "chat_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "shared_file_file_name"
    t.string   "shared_file_content_type"
    t.integer  "shared_file_file_size"
    t.datetime "shared_file_updated_at"
  end

  create_table "phrases", :force => true do |t|
    t.integer  "business_id"
    t.text     "phrase"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
