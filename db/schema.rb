# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_06_192911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "alerts", force: :cascade do |t|
    t.string "felony"
    t.text "description"
    t.string "level"
    t.boolean "solved"
    t.bigint "user_id", null: false
    t.bigint "passenger_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["passenger_id"], name: "index_alerts_on_passenger_id"
    t.index ["user_id"], name: "index_alerts_on_user_id"
  end

  create_table "bus_travels", force: :cascade do |t|
    t.date "departure_on"
    t.date "arrival_on"
    t.bigint "travel_line_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["travel_line_id"], name: "index_bus_travels_on_travel_line_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "company_name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "passenger_trips", force: :cascade do |t|
    t.integer "seat"
    t.string "arrival_spot"
    t.bigint "passenger_id", null: false
    t.bigint "bus_travel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bus_travel_id"], name: "index_passenger_trips_on_bus_travel_id"
    t.index ["passenger_id"], name: "index_passenger_trips_on_passenger_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.string "full_name"
    t.date "date_of_birth"
    t.string "gender"
    t.string "cpf"
    t.string "identification_number"
    t.string "identification_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "travel_lines", force: :cascade do |t|
    t.string "identification_number"
    t.string "origin"
    t.string "destination"
    t.string "departure_at"
    t.string "arrival_at"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_travel_lines_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "alerts", "passengers"
  add_foreign_key "alerts", "users"
  add_foreign_key "bus_travels", "travel_lines"
  add_foreign_key "companies", "users"
  add_foreign_key "passenger_trips", "bus_travels"
  add_foreign_key "passenger_trips", "passengers"
  add_foreign_key "travel_lines", "companies"
end
