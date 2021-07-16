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

ActiveRecord::Schema.define(version: 2021_07_16_084843) do

  create_table "prayer_configs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "gender", limit: 20, null: false
    t.string "prayer", limit: 20, null: false
    t.string "label", limit: 100, null: false
    t.integer "limit", null: false
    t.integer "status", limit: 2, null: false
    t.integer "group", limit: 2, default: 3, null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gender", "prayer", "status"], name: "index_prayer_configs_on_gender_and_prayer_and_status"
    t.index ["gender", "prayer"], name: "index_prayer_configs_on_gender_and_prayer", unique: true
  end

  create_table "requested_slots", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "gender", limit: 10, null: false
    t.string "prayer", limit: 10, null: false
    t.string "full_name", limit: 50
    t.string "phone_number", limit: 50
    t.string "email", limit: 50
    t.string "address_line_1", limit: 50
    t.string "address_line_2", limit: 50
    t.string "city", limit: 50
    t.string "postcode", limit: 50
    t.date "date", null: false
    t.integer "status", limit: 2, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prayer", "date", "status"], name: "index_requested_slots_phone_to_status"
    t.index ["user_id"], name: "index_requested_slots_on_user_id"
  end

  create_table "slot_availabilities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "prayer_config_id"
    t.date "date", null: false
    t.integer "available_slots", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date", "prayer_config_id"], name: "index_slot_availabilities_on_date_and_prayer_config_id", unique: true
    t.index ["prayer_config_id"], name: "index_slot_availabilities_on_prayer_config_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "phone_id", limit: 100, null: false
    t.integer "status", limit: 2, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["phone_id"], name: "index_users_on_phone_id", unique: true
  end

end
