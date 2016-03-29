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

ActiveRecord::Schema.define(version: 20160329122809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_categories", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "answer_id"
    t.integer  "category_id"
  end

  add_index "answer_categories", ["answer_id"], name: "index_answer_categories_on_answer_id", using: :btree
  add_index "answer_categories", ["category_id"], name: "index_answer_categories_on_category_id", using: :btree
  add_index "answer_categories", ["user_id"], name: "index_answer_categories_on_user_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.string   "text"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
    t.integer  "student_id"
    t.integer  "survey_id"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["student_id"], name: "index_answers_on_student_id", using: :btree
  add_index "answers", ["survey_id"], name: "index_answers_on_survey_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
  end

  add_index "categories", ["question_id"], name: "index_categories_on_question_id", using: :btree

  create_table "processed_answers", force: :cascade do |t|
    t.string   "stemmed_text"
    t.string   "unstemmed_text"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "answer_id"
  end

  add_index "processed_answers", ["answer_id"], name: "index_processed_answers_on_answer_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "index"
    t.string   "label"
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "survey_model_id"
  end

  add_index "questions", ["survey_model_id"], name: "index_questions_on_survey_model_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "identifier"
    t.string   "meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_models", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id"
    t.integer  "student_identifier", default: 0
  end

  add_index "survey_models", ["user_id"], name: "index_survey_models_on_user_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "survey_model_id"
  end

  add_index "surveys", ["survey_model_id"], name: "index_surveys_on_survey_model_id", using: :btree
  add_index "surveys", ["user_id"], name: "index_surveys_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "answer_categories", "answers"
  add_foreign_key "answer_categories", "categories"
  add_foreign_key "answer_categories", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "students"
  add_foreign_key "answers", "surveys"
  add_foreign_key "categories", "questions"
  add_foreign_key "processed_answers", "answers"
  add_foreign_key "questions", "survey_models"
  add_foreign_key "survey_models", "users"
  add_foreign_key "surveys", "survey_models"
  add_foreign_key "surveys", "users"
end
