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

ActiveRecord::Schema.define(version: 20210925165455) do

  create_table "cart", force: :cascade do |t|
    t.integer  "customer_entity_id", limit: 4
    t.float    "grand_total",        limit: 24
    t.string   "currency",           limit: 255
    t.integer  "items_count",        limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id",           limit: 4
    t.integer  "product_entity_id", limit: 4
    t.string   "sku",               limit: 20
    t.float    "base_price",        limit: 24
    t.text     "description",       limit: 65535
    t.integer  "item_qty",          limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "product_image_url", limit: 255
    t.string   "name",              limit: 255
  end

  create_table "customer_entity", force: :cascade do |t|
    t.string   "email",      limit: 100
    t.string   "name",       limit: 100
    t.string   "password",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "order", force: :cascade do |t|
    t.integer  "customer_entity_id", limit: 4
    t.integer  "cart_id",            limit: 4
    t.float    "grand_total",        limit: 24
    t.string   "currency",           limit: 255
    t.string   "status",             limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "order_item", force: :cascade do |t|
    t.integer  "order_id",          limit: 4
    t.integer  "product_entity_id", limit: 4
    t.string   "sku",               limit: 20
    t.string   "name",              limit: 255
    t.text     "description",       limit: 65535
    t.float    "base_price",        limit: 24
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "product_image_url", limit: 255
  end

  create_table "order_item_qty", force: :cascade do |t|
    t.integer  "order_item_id", limit: 4
    t.string   "item_status",   limit: 255
    t.float    "final_price",   limit: 24
    t.string   "barcode",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "product_entity", force: :cascade do |t|
    t.string   "sku",         limit: 20
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.float    "base_price",  limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "image_url",   limit: 255
  end

end
