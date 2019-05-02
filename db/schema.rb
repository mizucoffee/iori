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

ActiveRecord::Schema.define(version: 20190502064536) do

  create_table "arrangers_musics", force: :cascade do |t|
    t.integer "music_id"
    t.integer "artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
  end

  create_table "composers_musics", force: :cascade do |t|
    t.integer "music_id"
    t.integer "artist_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
  end

  create_table "likes", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lyricists_musics", force: :cascade do |t|
    t.integer "music_id"
    t.integer "artist_id"
  end

  create_table "musics", force: :cascade do |t|
    t.string  "name"
    t.integer "genre_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.integer  "music_id"
    t.integer  "user_id"
    t.string   "body"
    t.string   "color"
    t.integer  "review_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "singers_musics", force: :cascade do |t|
    t.integer "music_id"
    t.integer "artist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "display_name"
    t.string   "twitter_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
