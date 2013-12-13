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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131123121304) do

  create_table "categories", :force => true do |t|
    t.string "code"
    t.string "name"
    t.string "unit"
    t.string "slug"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "customers", :force => true do |t|
    t.string "code"
    t.string "first_name"
    t.string "last_name"
    t.text   "address"
    t.string "phone_number"
    t.string "slug"
  end

  add_index "customers", ["slug"], :name => "index_customers_on_slug", :unique => true

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "items", :force => true do |t|
    t.string  "code"
    t.string  "name"
    t.integer "category_id"
    t.float   "retail_price"
    t.integer "stock"
  end

  add_index "items", ["category_id"], :name => "index_items_on_category_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sales_invoice_details", :force => true do |t|
    t.string   "invoice_number"
    t.integer  "item_id"
    t.integer  "qty"
    t.float    "subtotal"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "sales_invoice_details", ["item_id"], :name => "index_sales_invoice_details_on_item_id"

  create_table "sales_invoices", :force => true do |t|
    t.string   "invoice_number"
    t.integer  "customer_id"
    t.datetime "transaction_date"
    t.string   "payment"
    t.string   "npwp"
    t.decimal  "ppn",              :precision => 12, :scale => 6
    t.integer  "user_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "sales_invoices", ["customer_id"], :name => "index_sales_invoices_on_customer_id"
  add_index "sales_invoices", ["user_id"], :name => "index_sales_invoices_on_user_id"

  create_table "supplier_items", :force => true do |t|
    t.integer "supplier_id"
    t.integer "item_id"
    t.float   "purchase_price"
  end

  add_index "supplier_items", ["item_id"], :name => "index_supplier_items_on_item_id"
  add_index "supplier_items", ["supplier_id"], :name => "index_supplier_items_on_supplier_id"

  create_table "suppliers", :force => true do |t|
    t.string "code"
    t.string "first_name"
    t.string "last_name"
    t.text   "address"
    t.string "phone_number"
    t.string "slug"
  end

  add_index "suppliers", ["slug"], :name => "index_suppliers_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "date_registered"
    t.string   "id_card"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role_id"
    t.boolean  "is_active"
    t.string   "email",                  :default => "", :null => false
    t.string   "address"
    t.string   "phone_number"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "avatar"
    t.string   "slug"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["id_card"], :name => "index_users_on_id_card", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
