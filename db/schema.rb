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

ActiveRecord::Schema.define(version: 20170623112809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.date "check_in_date"
    t.date "check_out_date"
    t.string "room_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_code"
    t.string "first_name"
    t.string "last_name"
    t.integer "sex", limit: 2
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "room_service_cart_items", force: :cascade do |t|
    t.integer "quantity"
    t.text "special_request"
    t.bigint "room_service_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_service_order_id"
    t.index ["room_service_item_id"], name: "index_room_service_cart_items_on_room_service_item_id"
    t.index ["room_service_order_id"], name: "index_room_service_cart_items_on_room_service_order_id"
  end

  create_table "room_service_cart_items_item_choice_options", id: false, force: :cascade do |t|
    t.bigint "room_service_cart_item_id", null: false
    t.bigint "room_service_item_choice_option_id", null: false
    t.index ["room_service_cart_item_id", "room_service_item_choice_option_id"], name: "by_r_s_cart_item_id_and_r_s_item_choice_option_id"
    t.index ["room_service_item_choice_option_id", "room_service_cart_item_id"], name: "by_r_s_item_choice_option_id_and_r_s_cart_item_id"
  end

  create_table "room_service_categories", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.time "available_from"
    t.time "available_until"
  end

  create_table "room_service_item_choice_options", force: :cascade do |t|
    t.string "title"
    t.decimal "price"
    t.bigint "room_service_item_choice_id"
    t.index ["room_service_item_choice_id"], name: "index_r_s_item_choice_options_on_r_s_item_choice_id"
  end

  create_table "room_service_item_choices", force: :cascade do |t|
    t.string "title"
    t.boolean "optional"
    t.boolean "allows_multiple_options"
    t.bigint "default_option_id"
    t.index ["default_option_id"], name: "index_room_service_item_choices_on_default_option_id"
  end

  create_table "room_service_item_choices_items", id: false, force: :cascade do |t|
    t.bigint "room_service_item_id", null: false
    t.bigint "room_service_item_choice_id", null: false
    t.index ["room_service_item_choice_id", "room_service_item_id"], name: "by_r_s_item_choice_id_and_r_s_item_id"
    t.index ["room_service_item_id", "room_service_item_choice_id"], name: "by_r_s_item_id_and_r_s_item_choice_id"
  end

  create_table "room_service_items", force: :cascade do |t|
    t.string "title"
    t.string "short_description"
    t.decimal "price", precision: 19, scale: 4, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.bigint "room_service_sub_category_id"
    t.index ["room_service_sub_category_id"], name: "index_room_service_items_on_room_service_sub_category_id"
  end

  create_table "room_service_items_tags", id: false, force: :cascade do |t|
    t.bigint "room_service_item_id", null: false
    t.bigint "room_service_tag_id", null: false
    t.index ["room_service_item_id", "room_service_tag_id"], name: "by_item_id_and_tag_id", unique: true
    t.index ["room_service_tag_id", "room_service_item_id"], name: "by_tag_id_and_item_id", unique: true
  end

  create_table "room_service_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "reservation_id"
    t.integer "status", limit: 2, default: 0
    t.index ["reservation_id"], name: "index_room_service_orders_on_reservation_id"
    t.index ["user_id"], name: "index_room_service_orders_on_user_id"
  end

  create_table "room_service_sub_categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_service_category_id"
    t.boolean "default", default: false
    t.integer "room_service_items_count", default: 0
    t.index ["room_service_category_id"], name: "index_room_service_sub_categories_on_room_service_category_id"
  end

  create_table "room_service_tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "auth_token"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "reservations", "users"
  add_foreign_key "room_service_cart_items", "room_service_items"
  add_foreign_key "room_service_cart_items", "room_service_orders"
  add_foreign_key "room_service_item_choice_options", "room_service_item_choices"
  add_foreign_key "room_service_items", "room_service_sub_categories"
  add_foreign_key "room_service_orders", "reservations"
  add_foreign_key "room_service_orders", "users"
  add_foreign_key "room_service_sub_categories", "room_service_categories"
end
