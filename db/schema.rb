ActiveRecord::Schema.define(version: 20170411031231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "gender"
    t.string   "occupation"
    t.string   "religion"
    t.string   "city"
    t.string   "post_code"
    t.string   "country"
    t.text     "self_summary"
    t.string   "preferred_gender"
    t.integer  "min_age"
    t.integer  "max_age"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "password_digest"
    t.date     "date_of_birth"
    t.string   "looking_for"
    t.string   "remember_digest"
    t.boolean  "admin",                            default: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "picture"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
