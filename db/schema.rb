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

ActiveRecord::Schema.define(version: 20141014085506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.string   "name",                      null: false
    t.integer  "view_count",   default: 0,  null: false
    t.string   "location",     default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "introduction", default: "", null: false
    t.string   "image"
    t.string   "email",                     null: false
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.text     "content",        null: false
    t.integer  "responds_to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id",      null: false
  end

  add_index "messages", ["artist_id"], name: "index_messages_on_artist_id", using: :btree
  add_index "messages", ["responds_to_id"], name: "index_messages_on_responds_to_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "movies", force: true do |t|
    t.string   "youtube_video_id",              null: false
    t.integer  "view_count",       default: 0,  null: false
    t.string   "title",            default: "", null: false
    t.text     "description",      default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id",                     null: false
  end

  add_index "movies", ["artist_id", "youtube_video_id"], name: "index_movies_on_artist_id_and_youtube_video_id", unique: true, using: :btree
  add_index "movies", ["artist_id"], name: "index_movies_on_artist_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "scouts", force: true do |t|
    t.string   "company",                 null: false
    t.string   "last_name",               null: false
    t.string   "first_name",              null: false
    t.string   "zip",                     null: false
    t.string   "prefecture",              null: false
    t.string   "city",                    null: false
    t.string   "address",                 null: false
    t.string   "building",   default: "", null: false
    t.string   "phone",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                   null: false
  end

  create_table "users", force: true do |t|
    t.string   "name",                 default: "", null: false
    t.string   "email",                default: "", null: false
    t.text     "introduction",         default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "google_uid"
    t.string   "google_token"
    t.datetime "remember_created_at"
    t.string   "remember_token"
    t.integer  "artist_id"
    t.integer  "scout_id"
    t.string   "image"
    t.integer  "expires_at"
    t.string   "google_refresh_token"
  end

  add_index "users", ["artist_id"], name: "index_users_on_artist_id", using: :btree
  add_index "users", ["google_uid"], name: "index_users_on_google_uid", unique: true, using: :btree
  add_index "users", ["scout_id"], name: "index_users_on_scout_id", using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
