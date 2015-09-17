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

ActiveRecord::Schema.define(version: 20150917110030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "category_id"
    t.string   "parent_id",   default: "0"
    t.string   "title"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id", using: :btree

  create_table "costs", force: :cascade do |t|
    t.string   "cost_id"
    t.string   "product_id"
    t.string   "pricetype_id"
    t.float    "price"
    t.string   "title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "costs", ["cost_id"], name: "index_costs_on_cost_id", using: :btree
  add_index "costs", ["pricetype_id"], name: "index_costs_on_pricetype_id", using: :btree
  add_index "costs", ["product_id"], name: "index_costs_on_product_id", using: :btree

  create_table "pricetypes", force: :cascade do |t|
    t.string   "pricetype_id"
    t.string   "title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "pricetypes", ["pricetype_id"], name: "index_pricetypes_on_pricetype_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "product_id"
    t.string   "category_id"
    t.string   "title"
    t.string   "part_number"
    t.text     "full_text"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["product_id"], name: "index_products_on_product_id", using: :btree

end
