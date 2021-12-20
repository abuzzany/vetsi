# frozen_string_literal: true

module Stocks
  # This class calculates the profit or loss for a set of
  # stocks.
  class CalculateProfitLoss
    attr_accessor :user_id,
                  :stock_symbol

    def self.run(user_id, stock_symbol)
      new(user_id, stock_symbol).run
    end

    def initialize(user_id, stock_symbol)
      @user_id = user_id
      @stock_symbol = stock_symbol
    end

    def run
      total = bought - selled
      total * Stocks::Info.new(stock_symbol).last_sale_price
    end

    private

    def bought
      Transaction.select(:share_quantity).where(
        user_id: user_id,
        transaction_type: :buy,
        stock_symbol: stock_symbol
      ).sum(:share_quantity)
    end

    def selled
      Transaction.select(:share_quantity).where(
        user_id: user_id,
        transaction_type: :sell,
        stock_symbol: stock_symbol
      ).sum(:share_quantity)
    end
  end
end
