# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_31_203606) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.integer "count", default: 0
    t.string "letters", default: [], array: true
    t.string "letters_colours", default: [], array: true
    t.bigint "user_id"
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_attempts_on_match_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "mode", default: 0
    t.datetime "finished_at"
    t.bigint "user_id"
    t.bigint "word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_matches_on_user_id"
    t.index ["word_id"], name: "index_matches_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "unconfirmed_email"
    t.string "reset_email_token"
    t.datetime "reset_email_sent_at"
    t.integer "wins", default: 0
    t.integer "losses", default: 0
    t.integer "streak", default: 0
    t.integer "best_streak", default: 0
  end

  create_table "words", force: :cascade do |t|
    t.integer "kind", default: 0
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
