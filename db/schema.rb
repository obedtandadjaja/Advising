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

ActiveRecord::Schema.define(version: 20160307212419) do

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

  create_table "course_prerequisites", force: :cascade do |t|
    t.integer  "course_id",       limit: 4
    t.integer  "prerequisite_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "subject",         limit: 255
    t.integer  "course_number",   limit: 4
    t.string   "title",           limit: 255
    t.string   "department_code", limit: 255
    t.integer  "cipc_code",       limit: 4
    t.integer  "hr_low",          limit: 4
    t.integer  "hr_high",         limit: 4
    t.string   "department_desc", limit: 255
    t.date     "date_offered"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "courses", ["subject", "course_number"], name: "index_courses_on_subject_and_course_number", unique: true, using: :btree

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
    t.string   "department",  limit: 255
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

  create_table "minors", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "department",  limit: 255
    t.integer  "total_hours", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "minors_courses", force: :cascade do |t|
    t.integer  "minor_id",   limit: 4
    t.integer  "course_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "plans_courses", force: :cascade do |t|
    t.integer  "plan_id",       limit: 4
    t.integer  "course_id",     limit: 4
    t.date     "taken_on"
    t.string   "taken_planned", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.integer  "enrollment_time",        limit: 4
    t.integer  "graduation_time",        limit: 4
    t.string   "banner_id",              limit: 255
    t.integer  "role",                   limit: 4,   default: 0
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_concentrations", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "concentration_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users_majors", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "major_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users_minors", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "minor_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users_plans", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "plan_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
