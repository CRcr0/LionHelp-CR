# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_14_194515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.string "commentee"
    t.text "content"
    t.integer "postID"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "location", null: false
    t.string "startTime", default: "11/14/2021 21:22"
    t.string "endTime", default: "11/14/2021 21:22"
    t.text "taskDetails", default: "More about the request"
    t.float "credit", null: false
    t.string "email", null: false
    t.boolean "helperStatus", default: false
    t.string "helperEmail"
    t.boolean "helperComplete", default: false
    t.boolean "requesterComplete", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "firstName"
    t.string "lastName"
    t.integer "credit", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
