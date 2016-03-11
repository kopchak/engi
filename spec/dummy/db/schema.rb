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

ActiveRecord::Schema.define(version: 20160311121921) do

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",      precision: 6, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "cars", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",      precision: 6, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "shopping_cart_addresses", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "street_address"
    t.string   "city"
    t.string   "country"
    t.string   "zipcode"
    t.string   "phone"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "shopping_cart_credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "expiration_month"
    t.string   "expiration_year"
    t.string   "cvv"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "shopping_cart_deliveries", force: :cascade do |t|
    t.decimal  "price",      precision: 5, scale: 2
    t.string   "title"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "shopping_cart_discounts", force: :cascade do |t|
    t.string   "code",                      null: false
    t.integer  "amount",                    null: false
    t.boolean  "new_state",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "shopping_cart_order_items", force: :cascade do |t|
    t.decimal  "price",        precision: 6, scale: 2
    t.integer  "quantity"
    t.integer  "product_id"
    t.string   "product_type"
    t.integer  "order_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "shopping_cart_order_items", ["order_id"], name: "index_shopping_cart_order_items_on_order_id"

  create_table "shopping_cart_orders", force: :cascade do |t|
    t.decimal  "total_price",         precision: 6, scale: 2
    t.date     "completed_date"
    t.string   "state"
    t.integer  "customer_id"
    t.string   "customer_type"
    t.integer  "delivery_id"
    t.integer  "discount_id"
    t.integer  "credit_card_id"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "shopping_cart_orders", ["billing_address_id"], name: "index_shopping_cart_orders_on_billing_address_id"
  add_index "shopping_cart_orders", ["credit_card_id"], name: "index_shopping_cart_orders_on_credit_card_id"
  add_index "shopping_cart_orders", ["delivery_id"], name: "index_shopping_cart_orders_on_delivery_id"
  add_index "shopping_cart_orders", ["discount_id"], name: "index_shopping_cart_orders_on_discount_id"
  add_index "shopping_cart_orders", ["shipping_address_id"], name: "index_shopping_cart_orders_on_shipping_address_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
