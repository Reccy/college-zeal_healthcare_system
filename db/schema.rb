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

ActiveRecord::Schema.define(version: 20180409005307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "doctor_id"
    t.bigint "patient_id"
    t.string "reason", null: false
    t.datetime "scheduled", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "medical_facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_head_id"
    t.index ["department_head_id"], name: "index_departments_on_department_head_id"
    t.index ["medical_facility_id"], name: "index_departments_on_medical_facility_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "superuser", default: false
    t.bigint "workplace_id"
    t.index ["email"], name: "index_doctors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true
    t.index ["workplace_id"], name: "index_doctors_on_workplace_id"
  end

  create_table "medical_facilities", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "description", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "facility_type", default: "Clinic", null: false
    t.bigint "facility_head_id"
    t.index ["facility_head_id"], name: "index_medical_facilities_on_facility_head_id"
  end

  create_table "patient_records", force: :cascade do |t|
    t.bigint "patient_id"
    t.bigint "doctor_id"
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_archived", default: false, null: false
    t.datetime "archived_at"
    t.index ["doctor_id"], name: "index_patient_records_on_doctor_id"
    t.index ["patient_id"], name: "index_patient_records_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_patients_on_doctor_id"
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "patients"
  add_foreign_key "departments", "doctors", column: "department_head_id"
  add_foreign_key "departments", "medical_facilities"
  add_foreign_key "doctors", "departments", column: "workplace_id"
  add_foreign_key "medical_facilities", "doctors", column: "facility_head_id"
  add_foreign_key "patient_records", "doctors"
  add_foreign_key "patient_records", "patients"
  add_foreign_key "patients", "doctors"
end
