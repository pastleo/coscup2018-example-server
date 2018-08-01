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

ActiveRecord::Schema.define(version: 2018_08_01_031649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chapters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order", default: 0, null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dialogs", force: :cascade do |t|
    t.text "script"
    t.string "mission_type"
    t.integer "mission_id"
    t.integer "order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "characters_id"
    t.integer "character_expression"
    t.index ["characters_id"], name: "index_dialogs_on_characters_id"
  end

  create_table "gacha_groups", force: :cascade do |t|
    t.integer "weight", default: 1
    t.bigint "gacha_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gacha_id"], name: "index_gacha_groups_on_gacha_id"
  end

  create_table "gacha_items", force: :cascade do |t|
    t.string "rewardable_type"
    t.bigint "rewardable_id"
    t.bigint "gacha_group_id"
    t.integer "weight", default: 1
    t.integer "amount", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gacha_group_id"], name: "index_gacha_items_on_gacha_group_id"
    t.index ["rewardable_type", "rewardable_id"], name: "index_gacha_items_on_rewardable_type_and_rewardable_id"
  end

  create_table "gachas", force: :cascade do |t|
    t.string "name"
    t.boolean "opened", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "store", null: false
    t.string "product_id", null: false
    t.string "transaction_id", null: false
    t.text "receipt", null: false
    t.datetime "purchased_at", null: false
    t.string "currency", null: false
    t.string "price", null: false
    t.integer "quantity", null: false
    t.boolean "verified", default: false, null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_id"], name: "index_payments_on_transaction_id", unique: true
    t.index ["user_id", "verified", "purchased_at"], name: "payment_orders"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "name"
    t.bigint "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order", default: 0, null: false
    t.index ["chapter_id"], name: "index_stories_on_chapter_id"
  end

  create_table "user_character_replationships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "character_id"
    t.integer "favorability", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_user_character_replationships_on_character_id"
    t.index ["user_id"], name: "index_user_character_replationships_on_user_id"
  end

  create_table "user_missions", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "mission_id"
    t.string "mission_type"
    t.boolean "completed", default: false, null: false
    t.integer "progress", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "canceled_at"
    t.index ["user_id"], name: "index_user_missions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
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
    t.string "username", null: false
    t.integer "stone", default: 0
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "gacha_groups", "gachas"
  add_foreign_key "gacha_items", "gacha_groups"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "payments", "users"
  add_foreign_key "stories", "chapters"
  add_foreign_key "user_character_replationships", "characters"
  add_foreign_key "user_character_replationships", "users"
end
