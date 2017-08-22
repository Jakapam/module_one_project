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

ActiveRecord::Schema.define(version: 20170822141048) do

  create_table "moves", force: :cascade do |t|
    t.string "name"
    t.integer "damage"
    t.integer "heal"
    t.integer "dodge_chance"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name"
  end

  create_table "roster", force: :cascade do |t|
    t.integer "trainer_id"
    t.integer "pokemon_id"
    t.integer "current_hp"
    t.integer "move_1_id"
    t.integer "move_2_id"
    t.integer "move_3_id"
    t.integer "move_4_id"
  end

  create_table "trainers", force: :cascade do |t|
    t.string "name"
    t.string "rival_name"
  end

end
