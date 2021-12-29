# frozen_string_literal: true

class CreateStockPriceLog < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_price_logs do |t|
      t.string :stock_symbol, null: false
      t.float :price, null: false, default: 0
      t.timestamps(null: false)
    end
  end
end
