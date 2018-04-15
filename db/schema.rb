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

ActiveRecord::Schema.define(version: 20180415172826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cake_prices", force: :cascade do |t|
    t.bigint "cake_id"
    t.integer "size"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cake_id"], name: "index_cake_prices_on_cake_id"
  end

  create_table "cakes", force: :cascade do |t|
    t.bigint "flavor_id"
    t.string "decorationImgURL", limit: 250
    t.text "comments"
    t.integer "levels"
    t.boolean "gallery"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flavor_id"], name: "index_cakes_on_flavor_id"
  end

  create_table "flavors", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "flavorImgURL", limit: 250
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "deliveryDate"
    t.text "deliveryAddress"
    t.string "deliveryPhone", limit: 13
    t.integer "status"
    t.text "comments"
    t.integer "paidStatus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
<<<<<<< HEAD
    t.bigint "cake_price_id"
=======
<<<<<<< HEAD
=======
    t.index ["cake_price_id"], name: "index_orders_on_cake_price_id"
>>>>>>> 5116753e9994dbcaf9ced84d90b008afadc40865
>>>>>>> eaa9950271b26256e1fa7f97140c6ebb2cbbee86
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "userName", limit: 12
    t.string "password", limit: 50
    t.boolean "role"
    t.string "name", limit: 80
    t.string "lastName", limit: 80
    t.string "phone", limit: 12
    t.string "email"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cake_prices", "cakes"
  add_foreign_key "cakes", "flavors"
  add_foreign_key "orders", "users"
end
