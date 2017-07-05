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

ActiveRecord::Schema.define(version: 20170619110957) do

  create_table "counts", force: :cascade do |t|
    t.decimal "amount", null: false
    t.date "date", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invoice_id"
    t.integer "meter_id"
    t.index ["meter_id"], name: "index_counts_on_meter_id"
  end

  create_table "flats", force: :cascade do |t|
    t.integer "area", null: false
    t.integer "tax", null: false
    t.integer "ownership"
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "user_id"
  end

  create_table "invoice_details", force: :cascade do |t|
    t.integer "invoice_id", null: false
    t.integer "resident_id", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "kaltwasser"
    t.decimal "warmwasser"
    t.decimal "heizung"
    t.decimal "strom"
    t.decimal "abfall"
    t.decimal "versicherung"
    t.decimal "steuer"
    t.decimal "niederschlag"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "year", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "erdgas"
    t.decimal "kamin"
    t.decimal "wartung"
    t.decimal "reinigung"
    t.decimal "strom"
    t.decimal "gesamt_strom"
    t.decimal "wasser"
    t.decimal "abwasser"
    t.decimal "niederschlag"
    t.decimal "abfall"
    t.decimal "grundsteuer"
    t.decimal "versicherung"
  end

  create_table "meters", force: :cascade do |t|
    t.string "name"
    t.integer "flat_id"
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expense_type"
    t.integer "user_id"
    t.integer "meter_id"
    t.decimal "initial_count"
    t.index ["meter_id"], name: "index_meters_on_meter_id"
  end

  create_table "residents", force: :cascade do |t|
    t.string "name"
    t.date "move_in"
    t.date "move_out"
    t.integer "flat_id", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "persons"
    t.index ["user_id"], name: "index_residents_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "current_invoice_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
