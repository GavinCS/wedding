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

ActiveRecord::Schema.define(version: 20141025085257) do

  create_table "accommodations", force: true do |t|
    t.string   "name"
    t.string   "contact_number"
    t.string   "email"
    t.string   "website"
    t.string   "image"
    t.string   "address"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: true do |t|
    t.string   "album_name"
    t.integer  "image_count",      default: 0
    t.boolean  "hide_from_public", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galleries", ["album_name"], name: "index_galleries_on_album_name", using: :btree

  create_table "guest_addresses", force: true do |t|
    t.integer  "guest_id"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "suburb"
    t.string   "postcode"
    t.string   "region"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guests", force: true do |t|
    t.string   "name"
    t.string   "partner_name"
    t.string   "email"
    t.string   "hashed_password",    limit: 40
    t.string   "salt",               limit: 40
    t.string   "access_token",       limit: 40
    t.integer  "pax",                           default: 1,     null: false
    t.boolean  "rsvp",                          default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kids"
    t.string   "notes"
    t.boolean  "save_the_date_mail"
    t.boolean  "rsvp_mail"
  end

  add_index "guests", ["email"], name: "index_guests_on_email", using: :btree

  create_table "images", force: true do |t|
    t.string   "images"
    t.string   "image_name"
    t.integer  "gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["image_name"], name: "index_images_on_image_name", using: :btree

  create_table "mail_templates", force: true do |t|
    t.string   "name"
    t.string   "template"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                       default: "", null: false
    t.string   "email",                      default: "", null: false
    t.string   "hashed_password", limit: 40
    t.string   "salt",            limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "wedding_hosts", force: true do |t|
    t.string   "groom_name"
    t.string   "bride_name"
    t.date     "wedding_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
