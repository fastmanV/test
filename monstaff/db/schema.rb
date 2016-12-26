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

ActiveRecord::Schema.define(version: 20160830085727) do

  create_table "graphics", force: :cascade do |t|
    t.string   "engname",    limit: 255
    t.string   "worktime",   limit: 255
    t.text     "comment",    limit: 16777215
    t.string   "date",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "graphics", ["user_id"], name: "index_graphics_on_user_id", using: :btree

  create_table "group_permissions", force: :cascade do |t|
    t.string   "read",       limit: 255
    t.string   "write",      limit: 255
    t.string   "remove",     limit: 255
    t.string   "group_id",   limit: 255
    t.string   "url_path",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "type",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "super",      limit: 255
  end

  create_table "loggs", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.text     "text_event", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "telnets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transport_events", force: :cascade do |t|
    t.string   "transportname", limit: 255
    t.string   "event_start",   limit: 255
    t.string   "event_end",     limit: 255
    t.text     "text",          limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "start_time",    limit: 255
    t.string   "end_time",      limit: 255
  end

  create_table "user_permissions", force: :cascade do |t|
    t.string   "read",       limit: 255
    t.string   "write",      limit: 255
    t.string   "remove",     limit: 255
    t.string   "user_id",    limit: 255
    t.string   "region_id",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "fullname",           limit: 255
    t.string   "salt",               limit: 255
    t.string   "encrypted_password", limit: 255
    t.string   "passactive",         limit: 255
    t.string   "phone",              limit: 255
    t.string   "mail",               limit: 255
    t.string   "vacstart",           limit: 255
    t.string   "vacend",             limit: 255
    t.integer  "region_id",          limit: 4
    t.integer  "group_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "graphics", "users"
end
