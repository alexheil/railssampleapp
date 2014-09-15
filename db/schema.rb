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

ActiveRecord::Schema.define(version: 20140914213800) do

  create_table "artists", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "location"
    t.string   "genre"
    t.string   "biography"
    t.string   "sounds_like"
    t.string   "members"
    t.string   "artist_name"
    t.boolean  "admin"
    t.string   "activation_digest"
    t.boolean  "activated",              default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "cover_img_file_name"
    t.string   "cover_img_content_type"
    t.integer  "cover_img_file_size"
    t.datetime "cover_img_updated_at"
  end

  add_index "artists", ["email"], name: "index_artists_on_email", unique: true

  create_table "microposts", force: true do |t|
    t.text     "content"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["artist_id", "created_at"], name: "index_microposts_on_artist_id_and_created_at"

end
