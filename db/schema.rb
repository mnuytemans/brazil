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

ActiveRecord::Schema.define(version: 20140517142420) do

  create_table "betjokers", force: true do |t|
    t.integer  "user_id"
    t.integer  "country_id"
    t.integer  "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
    t.boolean  "scored"
  end

  create_table "bets", force: true do |t|
    t.integer  "homescore"
    t.integer  "awayscore"
    t.integer  "betset_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "scored"
    t.integer  "score"
  end

  add_index "bets", ["betset_id", "game_id"], name: "index_bets_on_betset_id_and_game_id", unique: true

  create_table "betsets", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "betsets", ["user_id"], name: "index_betsets_on_user_id", unique: true

  create_table "bettables", force: true do |t|
    t.integer  "user_id"
    t.integer  "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
    t.boolean  "scored"
  end

  create_table "bettables_countries", id: false, force: true do |t|
    t.integer "bettable_id"
    t.integer "country_id"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries_tables", id: false, force: true do |t|
    t.integer "country_id"
    t.integer "table_id"
  end

  create_table "games", force: true do |t|
    t.string   "homeside"
    t.string   "awayside"
    t.integer  "homescore"
    t.integer  "awayscore"
    t.date     "playdate"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["group"], name: "index_games_on_group"
  add_index "games", ["playdate"], name: "index_games_on_playdate"

  create_table "rounds", force: true do |t|
    t.string   "name"
    t.integer  "teams"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tables", force: true do |t|
    t.integer  "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.integer  "score"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
