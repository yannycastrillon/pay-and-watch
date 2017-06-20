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

ActiveRecord::Schema.define(version: 20170301014102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "payments", force: :cascade do |t|
    t.string   "card_holder_name",      null: false
    t.string   "address"
    t.string   "city",                  null: false
    t.string   "state_province",        null: false
    t.integer  "postal_code"
    t.string   "email",                 null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "video_id",              null: false
    t.integer  "user_id",               null: false
    t.string   "stripe_customer_token"
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree
  add_index "payments", ["video_id"], name: "index_payments_on_video_id", using: :btree

  create_table "requests", force: :cascade do |t|
    t.string   "req_type",        null: false
    t.date     "date",            null: false
    t.integer  "req_st_id",       null: false
    t.string   "req_st_desc",     null: false
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "acc_curr_st_id"
    t.integer  "acc_chgTo_st_id"
    t.integer  "acc_old_st_id"
  end

  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.integer  "age",             null: false
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "admin"
    t.boolean  "active"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "price",       null: false
    t.text     "description"
    t.boolean  "active"
  end

  add_foreign_key "payments", "users"
  add_foreign_key "payments", "videos"
  add_foreign_key "requests", "users"
end
