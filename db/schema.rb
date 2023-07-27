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

ActiveRecord::Schema[7.0].define(version: 2023_07_26_085808) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "properties", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.boolean "is_available", default: true, null: false
    t.date "available_on"
    t.string "note"
    t.decimal "latitude", precision: 10, scale: 6, default: "0.0", null: false
    t.decimal "longitude", precision: 10, scale: 6, default: "0.0", null: false
    t.string "location", null: false
    t.integer "created_by", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "property_category_id", null: false
    t.bigint "property_type_id", null: false
    t.index ["property_category_id"], name: "index_properties_on_property_category_id"
    t.index ["property_type_id"], name: "index_properties_on_property_type_id"
  end

  create_table "property_categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "property_facilities", force: :cascade do |t|
    t.integer "furniture"
    t.integer "electric_power"
    t.integer "air_conditioner"
    t.integer "water_resource"
    t.integer "internet"
    t.integer "parking"
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_facilities_on_property_id"
  end

  create_table "property_generals", force: :cascade do |t|
    t.string "land_size", default: "0", null: false
    t.string "building_size", default: "0", null: false
    t.integer "floor_level"
    t.string "view"
    t.integer "style_design"
    t.string "surrounding"
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_generals_on_property_id"
  end

  create_table "property_indoors", force: :cascade do |t|
    t.integer "living_room"
    t.integer "dinning_room"
    t.integer "kitchen"
    t.integer "bedroom"
    t.integer "bathroom"
    t.integer "ensuite_bathroom"
    t.integer "maid_room"
    t.integer "storage"
    t.integer "guest_toilet"
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_indoors_on_property_id"
  end

  create_table "property_kind_costs", force: :cascade do |t|
    t.bigint "property_kind_id", null: false
    t.string "name", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_kind_id"], name: "index_property_kind_costs_on_property_kind_id"
  end

  create_table "property_kinds", force: :cascade do |t|
    t.integer "kind", default: 0, null: false
    t.decimal "price_cents", default: "0.0", null: false
    t.string "price_currency", default: "IDR", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "currency", default: "IDR"
    t.index ["kind", "property_id"], name: "index_property_kinds_on_kind_and_property_id", unique: true
    t.index ["property_id"], name: "index_property_kinds_on_property_id"
  end

  create_table "property_outdoors", force: :cascade do |t|
    t.integer "swimming_pool"
    t.integer "garden"
    t.integer "balcony"
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_outdoors_on_property_id"
  end

  create_table "property_rental_costs", force: :cascade do |t|
    t.bigint "property_rental_id", null: false
    t.string "name", null: false
    t.string "value", null: false
    t.index ["property_rental_id"], name: "index_property_rental_costs_on_property_rental_id"
  end

  create_table "property_rentals", force: :cascade do |t|
    t.integer "rental_type", default: 0, null: false
    t.decimal "price_cents", default: "0.0", null: false
    t.string "price_currency", default: "IDR", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "currency", default: "IDR"
    t.index ["property_id"], name: "index_property_rentals_on_property_id"
    t.index ["rental_type", "property_id"], name: "index_property_rentals_on_rental_type_and_property_id", unique: true
  end

  create_table "property_requests", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone", null: false
    t.string "email", null: false
    t.text "description", null: false
    t.string "property_category", null: false
    t.string "property_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "property_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "property_category_id", null: false
    t.index ["property_category_id"], name: "index_property_types_on_property_category_id"
  end

  create_table "visitors", force: :cascade do |t|
    t.inet "ip_address"
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_visitors_on_property_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "properties", "property_categories"
  add_foreign_key "properties", "property_types"
  add_foreign_key "property_facilities", "properties"
  add_foreign_key "property_generals", "properties"
  add_foreign_key "property_indoors", "properties"
  add_foreign_key "property_kind_costs", "property_kinds"
  add_foreign_key "property_kinds", "properties"
  add_foreign_key "property_outdoors", "properties"
  add_foreign_key "property_rental_costs", "property_rentals"
  add_foreign_key "property_rentals", "properties"
  add_foreign_key "property_types", "property_categories"
  add_foreign_key "visitors", "properties"
end
