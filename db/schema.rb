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

ActiveRecord::Schema.define(version: 20140506111158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "addressable_type", limit: 64
    t.integer  "addressable_id"
    t.string   "line_1",           limit: 128
    t.string   "line_2",           limit: 128
    t.string   "landmark",         limit: 128
    t.string   "city",             limit: 128
    t.string   "state",            limit: 128
    t.string   "postal_code",      limit: 16
    t.string   "country",          limit: 128
    t.string   "mobile",           limit: 16
    t.string   "phone_1",          limit: 16
    t.string   "phone_2",          limit: 16
    t.string   "email_1",          limit: 128
    t.string   "email_2",          limit: 128
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adjustments", force: true do |t|
    t.integer  "copy_id"
    t.integer  "item_id"
    t.date     "adjusted_date"
    t.integer  "adjusted_quantity",            default: 1
    t.string   "kind",              limit: 16
    t.string   "reason",            limit: 96
    t.string   "status",            limit: 16
    t.date     "return_date"
    t.date     "returned_date"
    t.text     "notes"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.integer  "parent_id"
    t.string   "code",       limit: 32
    t.string   "name",       limit: 64
    t.string   "kind",       limit: 32
    t.text     "notes"
    t.boolean  "active",                default: true
    t.boolean  "archived",              default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "copies", force: true do |t|
    t.integer  "item_id"
    t.string   "name",               limit: 128
    t.date     "procured_date"
    t.string   "format",             limit: 16
    t.integer  "length"
    t.string   "length_uom",         limit: 16
    t.string   "publisher",          limit: 128
    t.date     "published_date"
    t.decimal  "cost"
    t.decimal  "price"
    t.string   "quality",            limit: 32
    t.boolean  "issuable",                       default: true
    t.integer  "quantity",                       default: 1
    t.integer  "issued_quantity",                default: 0
    t.integer  "adjusted_quantity",              default: 0
    t.string   "status",             limit: 16
    t.string   "location",           limit: 64
    t.string   "photo",              limit: 128
    t.string   "remote_photo_url"
    t.text     "notes"
    t.boolean  "active",                         default: true
    t.boolean  "archived",                       default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creators", force: true do |t|
    t.string   "kind",             limit: 16
    t.string   "first_name",       limit: 64
    t.string   "middle_name",      limit: 64
    t.string   "last_name",        limit: 64
    t.string   "full_name",        limit: 192
    t.string   "sort_name",        limit: 192
    t.string   "photo",            limit: 128
    t.string   "remote_photo_url"
    t.text     "notes"
    t.boolean  "active",                       default: true
    t.boolean  "archived",                     default: false
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
    t.string   "kind",          limit: 16
    t.string   "status",        limit: 16
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
    t.integer  "creator_id"
    t.integer  "sequence"
    t.string   "role",       limit: 16
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "category_id"
    t.string   "code",             limit: 32
    t.string   "name",             limit: 128
    t.string   "alt_name",         limit: 128
    t.string   "subject",          limit: 32
    t.string   "kind",             limit: 16
    t.string   "format",           limit: 16
    t.integer  "length"
    t.string   "length_uom",       limit: 16
    t.string   "publisher",        limit: 128
    t.date     "published_date"
    t.string   "language",         limit: 16
    t.string   "isbn_10",          limit: 16
    t.string   "isbn_13",          limit: 16
    t.decimal  "cost"
    t.decimal  "price"
    t.string   "reference",        limit: 128
    t.string   "rights",           limit: 16
    t.string   "rating",           limit: 8
    t.string   "tags",             limit: 128
    t.text     "excerpt"
    t.string   "photo",            limit: 128
    t.string   "remote_photo_url"
    t.boolean  "copywise",                     default: true
    t.text     "notes"
    t.boolean  "active",                       default: true
    t.boolean  "archived",                     default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.integer  "membership_id"
    t.string   "code",          limit: 32
    t.string   "name",          limit: 128
    t.string   "kind",          limit: 16
    t.string   "gender",        limit: 8
    t.string   "age_group",     limit: 16
    t.string   "profession",    limit: 32
    t.date     "join_date"
    t.date     "renewal_date"
    t.date     "renewed_date"
    t.date     "closed_date"
    t.string   "status",        limit: 16
    t.string   "photo",         limit: 128
    t.text     "notes"
    t.boolean  "active",                    default: true
    t.boolean  "archived",                  default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.string   "code",       limit: 32
    t.string   "name",       limit: 128
    t.string   "kind",       limit: 16
    t.text     "notes"
    t.boolean  "active",                 default: true
    t.boolean  "archived",               default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", force: true do |t|
    t.integer  "member_id"
    t.date     "received_date"
    t.string   "kind",          limit: 16
    t.decimal  "amount"
    t.string   "mode",          limit: 16
    t.string   "status",        limit: 16
    t.string   "reference_1",   limit: 128
    t.string   "reference_2",   limit: 128
    t.string   "reference_3",   limit: 128
    t.text     "notes"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: true do |t|
    t.integer  "item_id"
    t.integer  "member_id"
    t.date     "reserved_date"
    t.string   "status",        limit: 16
    t.text     "notes"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name",          limit: 64
    t.integer  "resource_id"
    t.string   "resource_type", limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "rules", force: true do |t|
    t.integer  "category_id"
    t.integer  "membership_id"
    t.string   "mnemonic",      limit: 64
    t.string   "name",          limit: 128
    t.string   "value",         limit: 128
    t.text     "notes"
    t.boolean  "active",                    default: true
    t.boolean  "archived",                  default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                   limit: 128
    t.string   "email",                              default: "",    null: false
    t.string   "encrypted_password",                 default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 64
    t.string   "last_sign_in_ip",        limit: 64
    t.text     "notes"
    t.boolean  "active",                             default: true
    t.boolean  "archived",                           default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
