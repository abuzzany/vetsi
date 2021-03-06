# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :user_id, null: false
      t.integer :transaction_type, null: false
      t.string  :stock_symbol, null: false
      t.integer :share_quantity, null: false
      t.float :share_price, null: false
      t.float :total_amount, null: false
      t.timestamps(null: false)
    end
  end
end
