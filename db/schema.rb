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

ActiveRecord::Schema.define(version: 20140318220432) do

  create_table "addresses", force: true do |t|
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "line_1"
    t.string   "line_2"
    t.string   "landmark"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "mobile"
    t.string   "phone_1"
    t.string   "phone_2"
    t.string   "email_1"
    t.string   "email_2"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.integer  "parent_id"
    t.string   "code"
    t.string   "name"
    t.string   "kind"
    t.text     "notes"
    t.boolean  "active",      default: true
    t.boolean  "archived",    default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "copies", force: true do |t|
    t.integer  "item_id"
    t.string   "name"
    t.date     "procured_date"
    t.string   "status"
    t.string   "quality"
    t.integer  "quantity",        default: 1
    t.boolean  "issuable",        default: true
    t.boolean  "issued",          default: false
    t.string   "photo"
    t.string   "remote_photo_url"
    t.text     "notes"
    t.boolean  "active",          default: true
    t.boolean  "archived",        default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creators", force: true do |t|
    t.string   "kind"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "sort_name"
    t.text     "notes"
    t.boolean  "active",      default: true
    t.boolean  "archived",    default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", force: true do |t|
    t.integer  "copy_id"
    t.integer  "item_id"
    t.integer  "member_id"
    t.date     "issued_date"
    t.string   "kind"
    t.string   "status"
    t.date     "return_date"
    t.date     "returned_date"
    t.integer  "extension"
    t.text     "notes"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_creators", force: true do |t|
    t.integer  "item_id"
    t.string   "creator_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "category_id"
    t.string   "code"
    t.string   "name"
    t.string   "creator_id"
    t.string   "subject"
    t.string   "kind"
    t.string   "format"
    t.integer  "pages"
    t.string   "publisher"
    t.date     "published_date"
    t.string   "language"
    t.string   "isbn_10"
    t.string   "isbn_13"
    t.string   "reference"
    t.string   "rights"
    t.string   "rating"
    t.string   "tags"
    t.text     "excerpt"
    t.string   "photo"
    t.string   "remote_photo_url"
    t.text     "notes"
    t.boolean  "active",           default: true
    t.boolean  "archived",         default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.integer  "membership_id"
    t.string   "code"
    t.string   "name"
    t.string   "kind"
    t.string   "gender"
    t.string   "age_group"
    t.text     "notes"
    t.boolean  "active",      default: true
    t.boolean  "archived",    default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "kind"
    t.text     "notes"
    t.boolean  "active",      default: true
    t.boolean  "archived",    default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: true do |t|
    t.integer  "item_id"
    t.integer  "member_id"
    t.date     "reserved_date"
    t.string   "status"
    t.text     "notes"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "rules", force: true do |t|
    t.integer  "category_id"
    t.integer  "membership_id"
    t.string   "mnemonic"
    t.string   "name"
    t.integer  "value"
    t.text     "notes"
    t.boolean  "active",      default: true
    t.boolean  "archived",    default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.text     "notes"
    t.boolean  "active",                 default: true
    t.boolean  "archived",               default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
end
