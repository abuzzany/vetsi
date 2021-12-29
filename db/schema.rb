# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_211_224_020_212) do
  create_table 'stock_price_logs', force: :cascade do |t|
    t.string 'stock_symbol', null: false
    t.float 'price', default: 0.0, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'stocks', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'stock_symbol', null: false
    t.float 'total_shares', default: 0.0, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'transactions', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'transaction_type', null: false
    t.string 'stock_symbol', null: false
    t.integer 'share_quantity', null: false
    t.float 'share_price', null: false
    t.float 'total_amount', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
  end
end
