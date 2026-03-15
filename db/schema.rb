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

ActiveRecord::Schema[7.1].define(version: 2026_02_08_004216) do
  create_schema "auth"
  create_schema "extensions"
  create_schema "graphql"
  create_schema "graphql_public"
  create_schema "pgbouncer"
  create_schema "realtime"
  create_schema "storage"
  create_schema "vault"

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_graphql"
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "supabase_vault"
  enable_extension "uuid-ossp"

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

  create_table "liste_de_prix_items", force: :cascade do |t|
    t.bigint "liste_de_prix_id", null: false
    t.bigint "produit_id", null: false
    t.decimal "price"
    t.date "start_date"
    t.date "end_date"
    t.decimal "discount"
    t.string "discount_type"
    t.integer "discount_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expiration_date"
    t.index ["liste_de_prix_id"], name: "index_liste_de_prix_items_on_liste_de_prix_id"
    t.index ["produit_id"], name: "index_liste_de_prix_items_on_produit_id"
  end

  create_table "liste_de_prixes", force: :cascade do |t|
    t.bigint "supermarche_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false
    t.bigint "societe_id"
    t.bigint "user_id"
    t.index ["societe_id"], name: "index_liste_de_prixes_on_societe_id"
    t.index ["supermarche_id"], name: "index_liste_de_prixes_on_supermarche_id"
    t.index ["user_id"], name: "index_liste_de_prixes_on_user_id"
  end

  create_table "produits", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "udm"
    t.string "udm_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "societe_id"
    t.bigint "user_id"
    t.string "sku"
    t.boolean "promotion", default: false
    t.date "promotion_start_date"
    t.date "promotion_end_date"
    t.decimal "promotion_price", precision: 10, scale: 2
    t.integer "bulk_sale_quantity"
    t.decimal "bulk_sale_discount_percentage", precision: 5, scale: 2
    t.index ["sku"], name: "index_produits_on_sku", unique: true
    t.index ["societe_id"], name: "index_produits_on_societe_id"
    t.index ["user_id"], name: "index_produits_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "societes", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.bigint "ville_id", null: false
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ville_id"], name: "index_societes_on_ville_id"
  end

  create_table "supermarches", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "email"
    t.string "phone"
    t.bigint "ville_id", null: false
    t.string "code"
    t.string "quartier"
    t.string "lieu_dit"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.bigint "societe_id"
    t.bigint "user_id"
    t.index ["societe_id"], name: "index_supermarches_on_societe_id"
    t.index ["user_id"], name: "index_supermarches_on_user_id"
    t.index ["ville_id"], name: "index_supermarches_on_ville_id"
  end

  create_table "terminal_accesses", force: :cascade do |t|
    t.string "ip_address"
    t.string "country"
    t.string "url"
    t.text "user_agent"
    t.boolean "blocked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "device_brand"
    t.string "device_model"
    t.string "device_type"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "second_name"
    t.string "phone"
    t.bigint "role_id"
    t.bigint "societe_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["societe_id"], name: "index_users_on_societe_id"
  end

  create_table "villes", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "Planifiée"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "liste_de_prix_items", "liste_de_prixes"
  add_foreign_key "liste_de_prix_items", "produits"
  add_foreign_key "liste_de_prixes", "societes"
  add_foreign_key "liste_de_prixes", "supermarches", column: "supermarche_id"
  add_foreign_key "liste_de_prixes", "users"
  add_foreign_key "produits", "societes"
  add_foreign_key "produits", "users"
  add_foreign_key "societes", "villes"
  add_foreign_key "supermarches", "societes"
  add_foreign_key "supermarches", "users"
  add_foreign_key "supermarches", "villes"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "societes"
end
