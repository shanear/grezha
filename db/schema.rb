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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140612021545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "connections", force: true do |t|
    t.text     "note"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "occurred_at"
    t.string   "remote_id",       limit: 8, null: false
    t.integer  "organization_id"
  end

  add_index "connections", ["remote_id"], name: "index_connections_on_remote_id", unique: true, using: :btree

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.text     "bio"
    t.datetime "birthday"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "city"
    t.date     "last_seen"
    t.string   "remote_id",            limit: 8, null: false
    t.integer  "organization_id"
  end

  add_index "contacts", ["remote_id"], name: "index_contacts_on_remote_id", unique: true, using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "remember_token"
    t.string   "salt"
    t.string   "encrypted_password"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "organization_id"
  end

  create_table "vehicles", force: true do |t|
    t.string   "license_plate"
    t.text     "notes"
    t.string   "used_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_id",       limit: 8, null: false
    t.integer  "organization_id"
  end

  add_index "vehicles", ["remote_id"], name: "index_vehicles_on_remote_id", unique: true, using: :btree

end
