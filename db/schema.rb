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

ActiveRecord::Schema.define(version: 20150410021038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avatars", force: :cascade do |t|
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "cup_differential"
    t.integer  "season_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "gods", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", force: :cascade do |t|
    t.string   "token"
    t.integer  "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "league_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.boolean  "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "league_ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.integer  "rating"
    t.integer  "games_played"
    t.integer  "wins"
    t.integer  "losses"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "team"
    t.integer  "change_in_season_rating"
    t.integer  "change_in_league_rating"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "season_ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "season_id"
    t.integer  "rating"
    t.integer  "games_played"
    t.integer  "wins"
    t.integer  "losses"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.string   "name"
    t.date     "end_date"
    t.integer  "players_per_team"
    t.integer  "cups_per_team"
    t.text     "additional_rules"
    t.integer  "league_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "number_of_balls"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
