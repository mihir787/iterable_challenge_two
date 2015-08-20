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

ActiveRecord::Schema.define(version: 20150819175457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "price_buckets", force: :cascade do |t|
    t.integer  "price",        default: 10
    t.integer  "company_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "number_users", default: 0
  end

  add_index "price_buckets", ["company_id"], name: "index_price_buckets_on_company_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "charge"
    t.integer  "result",                     default: 0
    t.integer  "company_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "total_monthly_active_users"
  end

  add_index "transactions", ["company_id"], name: "index_transactions_on_company_id", using: :btree

  add_foreign_key "price_buckets", "companies"
  add_foreign_key "transactions", "companies"
end
