# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_20_013413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.bigint "house_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_documents_on_house_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "datetime"
    t.string "event_type"
    t.bigint "house_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_events_on_house_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "address"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "houses_users", id: false, force: :cascade do |t|
    t.bigint "house_id", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "house_id"], name: "index_houses_users_on_user_id_and_house_id"
  end

  create_table "maintenances", force: :cascade do |t|
    t.string "description"
    t.bigint "house_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_maintenances_on_event_id"
    t.index ["house_id"], name: "index_maintenances_on_house_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "phone_number"
    t.string "role_name"
    t.bigint "house_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_users_on_house_id"
  end

  add_foreign_key "documents", "houses"
  add_foreign_key "maintenances", "events"
  add_foreign_key "maintenances", "houses"
  add_foreign_key "users", "houses"
end
