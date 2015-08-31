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

ActiveRecord::Schema.define(version: 20150825052635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avatars", force: :cascade do |t|
    t.binary   "data"
    t.string   "mime_type"
    t.string   "filename"
    t.integer  "participant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "avatars", ["participant_id"], name: "index_avatars_on_participant_id", using: :btree

  create_table "citizen_profiles", force: :cascade do |t|
    t.boolean  "outgoing",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "story_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "companies", ["story_id"], name: "index_companies_on_story_id", using: :btree

  create_table "issues", force: :cascade do |t|
    t.string   "name"
    t.integer  "story_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "issues", ["story_id"], name: "index_issues_on_story_id", using: :btree

  create_table "local_chapters", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_profiles", force: :cascade do |t|
    t.integer  "membership_typ", default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "participants", force: :cascade do |t|
    t.string   "first_name",       null: false
    t.string   "last_name",        null: false
    t.integer  "profile_id",       null: false
    t.string   "profile_type",     null: false
    t.integer  "local_chapter_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "participants", ["local_chapter_id"], name: "index_participants_on_local_chapter_id", using: :btree
  add_index "participants", ["profile_type", "profile_id"], name: "index_participants_on_profile_type_and_profile_id", using: :btree

  create_table "state_names", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "state_names", ["name"], name: "index_state_names_on_name", using: :btree
  add_index "state_names", ["state_id"], name: "index_state_names_on_state_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "country",                               null: false
    t.string   "default_name",                          null: false
    t.decimal  "lat",          precision: 10, scale: 6
    t.decimal  "lng",          precision: 10, scale: 6
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "states", ["country"], name: "index_states_on_country", using: :btree

  create_table "stories", force: :cascade do |t|
    t.string   "title"
    t.text     "highlight"
    t.integer  "participant_id"
    t.integer  "state_id"
    t.date     "date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "stories", ["participant_id"], name: "index_stories_on_participant_id", using: :btree
  add_index "stories", ["state_id"], name: "index_stories_on_state_id", using: :btree

  create_table "talent_profiles", force: :cascade do |t|
    t.boolean  "outgoing",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "state_names", "states"
  add_foreign_key "stories", "participants"
  add_foreign_key "stories", "states"
end
