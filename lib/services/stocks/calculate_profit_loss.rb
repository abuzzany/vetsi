# frozen_string_literal: true

module Stocks
  # This service calculates the percentage of profit or loss of
  # a stock for a given user.
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
      total = bought_shares - selled_shares
      total * NasdaqClient::Quotes.new(stock_symbol).last_sale_price
    end

    private

    def bought_shares
      Shares::CalculateHeldQuantity.run(user_id, stock_symbol, :buy)
    end

    def selled_shares
      Shares::CalculateHeldQuantity.run(user_id, stock_symbol, :sell)
    end
  end
end
