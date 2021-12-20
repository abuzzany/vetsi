# frozen_string_literal: true

module Shares
  # This class calculates the quantity for given
  # stock symbol.
  class CalculateHeldQuantity
    attr_accessor :user_id,
                  :stock_symbol,
                  :transaction_type

    def self.run(user_id, stock_symbol, transaction_type)
      new(user_id, stock_symbol, transaction_type).run
    end

    def initialize(user_id, stock_symbol, transaction_type)
      @user_id = user_id
      @stock_symbol = stock_symbol
      @transaction_type = transaction_type
    end

    def run
      Transaction.select(:share_quantity).where(
        user_id: user_id,
        transaction_type: transaction_type,
        stock_symbol: stock_symbol
      ).sum(:share_quantity)
    end
  end
end
