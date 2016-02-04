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

ActiveRecord::Schema.define(version: 20160204140653334323) do

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "avg",           limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categoryz3_categories", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "parent_id",         limit: 4
    t.integer  "items_count",       limit: 4,   default: 0
    t.integer  "child_items_count", limit: 4,   default: 0
    t.integer  "childrens_count",   limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categoryz3_categories", ["name"], name: "index_categoryz3_categories_on_name", using: :btree
  add_index "categoryz3_categories", ["parent_id"], name: "index_categoryz3_categories_on_parent_id", using: :btree

  create_table "categoryz3_child_items", force: :cascade do |t|
    t.integer  "category_id",        limit: 4,   null: false
    t.integer  "categorizable_id",   limit: 4,   null: false
    t.string   "categorizable_type", limit: 255, null: false
    t.integer  "master_item_id",     limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categoryz3_child_items", ["categorizable_type", "categorizable_id"], name: "child_items_categorizable_idx", using: :btree
  add_index "categoryz3_child_items", ["category_id", "categorizable_type", "categorizable_id", "master_item_id"], name: "child_items_unq_idx", unique: true, using: :btree
  add_index "categoryz3_child_items", ["category_id", "created_at"], name: "index_categoryz3_child_items_on_category_id_and_created_at", using: :btree
  add_index "categoryz3_child_items", ["master_item_id"], name: "index_categoryz3_child_items_on_master_item_id", using: :btree

  create_table "categoryz3_items", force: :cascade do |t|
    t.integer  "category_id",        limit: 4,   null: false
    t.integer  "categorizable_id",   limit: 4,   null: false
    t.string   "categorizable_type", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categoryz3_items", ["categorizable_type", "categorizable_id"], name: "items_categorizable_idx", using: :btree
  add_index "categoryz3_items", ["category_id", "categorizable_type", "categorizable_id"], name: "items_unq_idx", unique: true, using: :btree
  add_index "categoryz3_items", ["category_id", "created_at"], name: "index_categoryz3_items_on_category_id_and_created_at", using: :btree

  create_table "overall_averages", force: :cascade do |t|
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "overall_avg",   limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "price",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
    t.string   "image",       limit: 255
  end

  add_index "products", ["user_id"], name: "fk_rails_dee2631783", using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "stars",         limit: 24,  null: false
    t.string   "dimension",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id",   limit: 4
    t.string   "cacheable_type", limit: 255
    t.float    "avg",            limit: 24,  null: false
    t.integer  "qty",            limit: 4,   null: false
    t.string   "dimension",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",     null: false
    t.string   "encrypted_password",     limit: 255,   default: "",     null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.text     "address",                limit: 65535
    t.string   "role",                   limit: 255,   default: "USER"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "products", "users"
end
