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

ActiveRecord::Schema.define(version: 20170517084632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "room_service_item_attributes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_service_item_option_choices", force: :cascade do |t|
    t.string "title"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_service_item_option_id"
    t.index ["room_service_item_option_id"], name: "by_room_service_item_option_id"
  end

  create_table "room_service_item_options", force: :cascade do |t|
    t.string "title"
    t.boolean "optional", default: true
    t.boolean "allows_multiple_choices", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "default_choice_id"
    t.index ["default_choice_id"], name: "index_room_service_item_options_on_default_choice_id"
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

  create_table "room_service_items_room_service_item_attributes", id: false, force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "item_attribute_id", null: false
    t.index ["item_attribute_id", "item_id"], name: "by_item_attribute_id_and_item_id", unique: true
    t.index ["item_id", "item_attribute_id"], name: "by_item_id_and_item_attribute_id", unique: true
  end

  create_table "room_service_items_room_service_item_options", id: false, force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "item_option_id", null: false
    t.index ["item_id", "item_option_id"], name: "by_item_id_and_item_option_id", unique: true
    t.index ["item_option_id", "item_id"], name: "by_item_option_id_and_item_id", unique: true
  end

  create_table "room_service_sections", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_service_category_id"
    t.boolean "default", default: false
    t.integer "room_service_items_count", default: 0
    t.index ["room_service_category_id"], name: "index_room_service_sections_on_room_service_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "room_service_item_option_choices", "room_service_item_options"
  add_foreign_key "room_service_item_options", "room_service_item_option_choices", column: "default_choice_id"
  add_foreign_key "room_service_items", "room_service_sections"
  add_foreign_key "room_service_sections", "room_service_categories"
end
