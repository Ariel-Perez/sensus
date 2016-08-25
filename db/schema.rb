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

ActiveRecord::Schema.define(version: 20160825155815) do

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

  create_table "answer_sentiments", force: :cascade do |t|
    t.integer  "answer_id"
    t.integer  "sentiment_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "answer_sentiments", ["answer_id"], name: "index_answer_sentiments_on_answer_id", using: :btree
  add_index "answer_sentiments", ["sentiment_id"], name: "index_answer_sentiments_on_sentiment_id", using: :btree
  add_index "answer_sentiments", ["user_id"], name: "index_answer_sentiments_on_user_id", using: :btree

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

  create_table "close_ended_answers", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "close_ended_question_id"
    t.integer  "survey_id"
    t.integer  "option_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "close_ended_answers", ["close_ended_question_id"], name: "index_close_ended_answers_on_close_ended_question_id", using: :btree
  add_index "close_ended_answers", ["option_id"], name: "index_close_ended_answers_on_option_id", using: :btree
  add_index "close_ended_answers", ["student_id"], name: "index_close_ended_answers_on_student_id", using: :btree
  add_index "close_ended_answers", ["survey_id"], name: "index_close_ended_answers_on_survey_id", using: :btree

  create_table "close_ended_questions", force: :cascade do |t|
    t.integer  "survey_model_id"
    t.integer  "index"
    t.string   "label"
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "close_ended_questions", ["survey_model_id"], name: "index_close_ended_questions_on_survey_model_id", using: :btree

  create_table "close_ended_questions_options", id: false, force: :cascade do |t|
    t.integer "close_ended_question_id"
    t.integer "option_id"
  end

  add_index "close_ended_questions_options", ["close_ended_question_id"], name: "index_close_ended_questions_options_on_close_ended_question_id", using: :btree
  add_index "close_ended_questions_options", ["option_id"], name: "index_close_ended_questions_options_on_option_id", using: :btree

  create_table "filter_values", force: :cascade do |t|
    t.string   "value"
    t.integer  "filter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "filter_values", ["filter_id"], name: "index_filter_values_on_filter_id", using: :btree

  create_table "filters", force: :cascade do |t|
    t.string   "name"
    t.integer  "survey_model_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "filters", ["survey_model_id"], name: "index_filters_on_survey_model_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "processed_answers", force: :cascade do |t|
    t.string   "stemmed_text"
    t.string   "unstemmed_text"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "answer_id"
    t.string   "original_text"
  end

  add_index "processed_answers", ["answer_id"], name: "index_processed_answers_on_answer_id", using: :btree

  create_table "question_relationships", id: false, force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "close_ended_question_id"
    t.text     "name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "question_relationships", ["close_ended_question_id"], name: "index_question_relationships_on_close_ended_question_id", using: :btree
  add_index "question_relationships", ["question_id"], name: "index_question_relationships_on_question_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "index"
    t.string   "label"
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "survey_model_id"
  end

  add_index "questions", ["survey_model_id"], name: "index_questions_on_survey_model_id", using: :btree

  create_table "sentiments", force: :cascade do |t|
    t.string "name"
  end

  create_table "student_survey_filter_values", force: :cascade do |t|
    t.integer  "filter_value_id"
    t.integer  "survey_id"
    t.integer  "student_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "student_survey_filter_values", ["filter_value_id"], name: "index_student_survey_filter_values_on_filter_value_id", using: :btree
  add_index "student_survey_filter_values", ["student_id"], name: "index_student_survey_filter_values_on_student_id", using: :btree
  add_index "student_survey_filter_values", ["survey_id"], name: "index_student_survey_filter_values_on_survey_id", using: :btree

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
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id"
    t.integer  "survey_model_id"
    t.boolean  "display",         default: true
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
  add_foreign_key "answer_sentiments", "answers"
  add_foreign_key "answer_sentiments", "sentiments"
  add_foreign_key "answer_sentiments", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "students"
  add_foreign_key "answers", "surveys"
  add_foreign_key "categories", "questions"
  add_foreign_key "close_ended_answers", "close_ended_questions"
  add_foreign_key "close_ended_answers", "options"
  add_foreign_key "close_ended_answers", "students"
  add_foreign_key "close_ended_answers", "surveys"
  add_foreign_key "close_ended_questions", "survey_models"
  add_foreign_key "filter_values", "filters"
  add_foreign_key "filters", "survey_models"
  add_foreign_key "processed_answers", "answers"
  add_foreign_key "question_relationships", "close_ended_questions"
  add_foreign_key "question_relationships", "questions"
  add_foreign_key "questions", "survey_models"
  add_foreign_key "student_survey_filter_values", "filter_values"
  add_foreign_key "student_survey_filter_values", "students"
  add_foreign_key "student_survey_filter_values", "surveys"
  add_foreign_key "survey_models", "users"
  add_foreign_key "surveys", "survey_models"
  add_foreign_key "surveys", "users"
end
