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

ActiveRecord::Schema.define(version: 20170403093620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auditoria", force: :cascade do |t|
    t.string   "name"
    t.integer  "capacity"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.integer  "speaker_id"
    t.integer  "auditorium_id"
    t.string   "topic"
    t.integer  "students_count"
    t.date     "date"
    t.time     "time_start"
    t.time     "time_end"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["auditorium_id"], name: "index_lectures_on_auditorium_id", using: :btree
    t.index ["speaker_id"], name: "index_lectures_on_speaker_id", using: :btree
  end

  create_table "lectures_schools", id: false, force: :cascade do |t|
    t.integer "lecture_id", null: false
    t.integer "school_id",  null: false
    t.index ["lecture_id", "school_id"], name: "index_lectures_schools_on_lecture_id_and_school_id", using: :btree
  end

  create_table "materials", force: :cascade do |t|
    t.integer "lecture_id"
    t.string  "video"
    t.string  "link"
    t.index ["lecture_id"], name: "index_materials_on_lecture_id", using: :btree
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.integer  "students_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "url"
  end

  create_table "speakers", force: :cascade do |t|
    t.string   "name"
    t.string   "workplace"
    t.string   "description"
    t.string   "photo_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "lectures", "auditoria"
  add_foreign_key "lectures", "speakers"
  add_foreign_key "materials", "lectures"
end
