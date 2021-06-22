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

ActiveRecord::Schema.define(:version => 20210621082127) do

  create_table "folders", :force => true do |t|
    t.integer  "folder_id",   :limit => 8,                    :null => false
    t.string   "folder_name",                                 :null => false
    t.boolean  "is_deleted",               :default => false, :null => false
    t.integer  "user_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "folders", ["folder_id"], :name => "index_folders_on_folder_id"

  create_table "notes", :force => true do |t|
    t.integer  "note_id",           :limit => 8,                    :null => false
    t.string   "notes_title",                                       :null => false
    t.string   "notes_description",                                 :null => false
    t.boolean  "is_deleted",                     :default => false, :null => false
    t.integer  "folder_id"
    t.integer  "user_id"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "notes", ["note_id"], :name => "index_notes_on_note_id"

  create_table "users", :force => true do |t|
    t.integer  "user_id",          :limit => 8,                    :null => false
    t.string   "user_first_name"
    t.string   "user_last_name"
    t.string   "user_role"
    t.string   "user_password"
    t.boolean  "is_login_enabled",              :default => false, :null => false
    t.boolean  "is_deleted",                    :default => false, :null => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "users", ["user_id"], :name => "index_users_on_user_id"

end
