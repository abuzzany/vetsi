# frozen_string_literal: true

module Stocks
  # This service calculates the percentage of profit or loss of
  # a stock for a given user.
  class CalculateProfitLoss
    attr_accessor :user_id,
                  :stock_symbol,
                  :last_sale_price

    def self.run(user_id, stock_symbol)
      new(user_id, stock_symbol).run
    end

    def initialize(user_id, stock_symbol)
      @user_id = user_id
      @stock_symbol = stock_symbol
      @last_sale_price = NasdaqClient::Quotes.new(stock_symbol).last_sale_price
    end

    def run
      (((current_stock_value - bought_stock_value) / current_stock_value) * 100).round(2)
    end

    private

    def bought_stock_value
      bought_shares_value - sold_shares_value
    end

    def current_stock_value
      Stocks::CalculateCurrentStockValue.run(user_id, stock_symbol)
    end

    def bought_shares_value
      Transaction.where(
        user_id: user_id,
        transaction_type: :buy,
        stock_symbol: stock_symbol
      ).sum(:total_amount)
    end

    def sold_shares_value
      Transaction.where(
        user_id: user_id,
        transaction_type: :sell,
        stock_symbol: stock_symbol
      ).sum(:total_amount)
    end
  end
end
