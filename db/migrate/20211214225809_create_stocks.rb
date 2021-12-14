class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.integer :user_id, null: false
      t.string :stock_symbol, null: false
      t.float :total_shares, null: false
      t.timestamps(null: false)
    end
  end
end
