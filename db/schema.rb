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

ActiveRecord::Schema[7.1].define(version: 2024_02_23_134037) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "formatted_address", null: false
    t.string "postal_code", null: false
    t.string "place_id", null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_weather_id", null: false
    t.index ["current_weather_id"], name: "index_addresses_on_current_weather_id"
    t.index ["place_id"], name: "index_addresses_on_place_id", unique: true
  end

  create_table "current_weathers", force: :cascade do |t|
    t.string "postal_code", null: false
    t.decimal "temp"
    t.decimal "feels_like"
    t.decimal "humidity"
    t.decimal "wind_speed"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "high_temp"
    t.decimal "low_temp"
    t.index ["expires_at"], name: "index_current_weathers_on_expires_at"
    t.index ["postal_code"], name: "index_current_weathers_on_postal_code", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  add_foreign_key "addresses", "current_weathers"
end
