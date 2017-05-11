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

ActiveRecord::Schema.define(version: 20170511173124) do

  create_table "counts", force: :cascade do |t|
    t.integer "meter_id", null: false
    t.decimal "amount", null: false
    t.date "date", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.string "name"
    t.integer "invoice_id", null: false
    t.decimal "amount", null: false
    t.integer "cost_type", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flats", force: :cascade do |t|
    t.integer "area", null: false
    t.integer "tax", null: false
    t.integer "ownership"
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_details", force: :cascade do |t|
    t.integer "invoice_id", null: false
    t.integer "expense_id", null: false
    t.integer "resident_id", null: false
    t.decimal "amount"
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "year", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meters", force: :cascade do |t|
    t.string "name"
    t.integer "flat_id", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "residents", force: :cascade do |t|
    t.string "name"
    t.date "move_in"
    t.date "move_out"
    t.integer "flat_id", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password"
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
