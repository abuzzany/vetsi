# frozen_string_literal: true

class Transaction < ActiveRecord::Base
  validates_presence_of :user_id,
                        :transaction_type,
                        :stock_symbol,
                        :share_quantity,
                        :share_price

  enum transaction_type: { sell: 0, buy: 1 }
end
