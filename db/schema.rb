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

ActiveRecord::Schema.define(version: 20170528161554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.date "check_in_date"
    t.date "check_out_date"
    t.integer "room_number"
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

  create_table "room_service_categories", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "room_service_choices", force: :cascade do |t|
    t.string "title"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_service_option_id"
    t.index ["room_service_option_id"], name: "by_room_service_option_id"
  end

  create_table "room_service_choices_for_options", force: :cascade do |t|
    t.bigint "room_service_option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_service_cart_item_id"
    t.index ["room_service_cart_item_id"], name: "room_service_choices_for_options_on_cart_item_id"
    t.index ["room_service_option_id"], name: "room_service_choices_for_options_on_option_id"
  end

  create_table "room_service_choices_for_options_room_service_choices", id: false, force: :cascade do |t|
    t.bigint "choices_for_option_id", null: false
    t.bigint "choice_id", null: false
    t.index ["choice_id", "choices_for_option_id"], name: "by_choice_id_and_choices_for_option_id", unique: true
    t.index ["choices_for_option_id", "choice_id"], name: "by_choices_for_option_id_and_choice_id", unique: true
  end

  create_table "room_service_items", force: :cascade do |t|
    t.string "title"
    t.string "short_description"
    t.decimal "price", precision: 19, scale: 4, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_service_section_id"
    t.text "long_description"
    t.index ["room_service_section_id"], name: "index_room_service_items_on_room_service_section_id"
  end

  create_table "room_service_items_room_service_options", id: false, force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "option_id", null: false
    t.index ["item_id", "option_id"], name: "by_item_id_and_option_id", unique: true
    t.index ["option_id", "item_id"], name: "by_option_id_and_item_id", unique: true
  end

  create_table "room_service_items_room_service_tags", id: false, force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "tag_id", null: false
    t.index ["item_id", "tag_id"], name: "by_item_id_and_tag_id", unique: true
    t.index ["tag_id", "item_id"], name: "by_tag_id_and_item_id", unique: true
  end

  create_table "room_service_options", force: :cascade do |t|
    t.string "title"
    t.boolean "optional", default: true
    t.boolean "allows_multiple_choices", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "default_room_service_choice_id"
    t.index ["default_room_service_choice_id"], name: "index_room_service_options_on_default_room_service_choice_id"
  end

  create_table "room_service_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "reservation_id"
    t.index ["reservation_id"], name: "index_room_service_orders_on_reservation_id"
    t.index ["user_id"], name: "index_room_service_orders_on_user_id"
  end

  create_table "room_service_sections", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_service_category_id"
    t.boolean "default", default: false
    t.integer "room_service_items_count", default: 0
    t.bigint "category_id"
    t.index ["category_id"], name: "index_room_service_sections_on_category_id"
    t.index ["room_service_category_id"], name: "index_room_service_sections_on_room_service_category_id"
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
  add_foreign_key "room_service_choices", "room_service_options"
  add_foreign_key "room_service_choices_for_options", "room_service_cart_items"
  add_foreign_key "room_service_choices_for_options", "room_service_options"
  add_foreign_key "room_service_items", "room_service_sections"
  add_foreign_key "room_service_options", "room_service_choices", column: "default_room_service_choice_id"
  add_foreign_key "room_service_orders", "reservations"
  add_foreign_key "room_service_orders", "users"
  add_foreign_key "room_service_sections", "room_service_categories"
  add_foreign_key "room_service_sections", "room_service_categories", column: "category_id"
end
