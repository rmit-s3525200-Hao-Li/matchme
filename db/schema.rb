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

ActiveRecord::Schema.define(version: 20170422125449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "occupation"
    t.string   "religion"
    t.date     "date_of_birth"
    t.string   "picture"
    t.string   "smoke"
    t.string   "drink"
    t.text     "self_summary"
    t.string   "city"
    t.string   "post_code"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "looking_for"
    t.string   "preferred_gender"
    t.integer  "min_age"
    t.integer  "max_age"
    t.text     "movies"
    t.text     "tv_shows"
    t.text     "books"
    t.text     "games"
    t.text     "sports"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "nearby"
    t.string   "edu_status"
    t.string   "edu_type"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "profiles", "users"
end
