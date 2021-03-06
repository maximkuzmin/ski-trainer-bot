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

ActiveRecord::Schema.define(version: 20180311171731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "training_participations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "training_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_id"], name: "index_training_participations_on_training_id"
    t.index ["user_id"], name: "index_training_participations_on_user_id"
  end

  create_table "training_plans", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "training_plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_plan_id"], name: "index_trainings_on_training_plan_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "telegram_id"
    t.string "sex"
    t.integer "age"
    t.bigint "training_plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_plan_id"], name: "index_users_on_training_plan_id"
  end

  add_foreign_key "training_participations", "trainings"
  add_foreign_key "training_participations", "users"
  add_foreign_key "trainings", "training_plans"
  add_foreign_key "users", "training_plans"
end
