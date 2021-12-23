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
      total = Shares::CalculateHeldQuantity.run(user_id, stock_symbol,
                                                :buy) - Shares::CalculateHeldQuantity.run(user_id, stock_symbol,
                                                                                          :sell)
      total * Stocks::Info.new(stock_symbol).last_sale_price
    end
  end
end
