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

ActiveRecord::Schema.define(version: 20150923050353) do

  create_table "concentrations", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "total_hours", limit: 4
    t.integer  "major_id",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "concentrations_courses", force: :cascade do |t|
    t.integer  "concentration_id", limit: 4
    t.integer  "course_id",        limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "subject",      limit: 255
    t.integer  "number",       limit: 4
    t.integer  "credit",       limit: 4
    t.date     "date_offered"
    t.integer  "crn",          limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "distributions", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "distributions_courses", force: :cascade do |t|
    t.integer  "distribution_id", limit: 4
    t.integer  "course_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "majors", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "total_hours", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "majors_courses", force: :cascade do |t|
    t.integer  "major_id",   limit: 4
    t.integer  "course_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255
    t.string   "password_digest",  limit: 255
    t.integer  "enrollment_time",  limit: 4
    t.integer  "major_id",         limit: 4
    t.integer  "concentration_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users_courses", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "course_id",  limit: 4
    t.date     "taken_on"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
