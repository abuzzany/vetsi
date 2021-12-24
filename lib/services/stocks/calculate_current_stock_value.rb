# frozen_string_literal: true

module Stocks
  # This service calculates the current value of a stock for a given user.
  class CalculateCurrentStockValue
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
      total_shares = bought_shares - sold_shares
      total_shares * last_sale_price
    end

    private

    def bought_shares
      @bought_shares ||= Shares::CalculateHeldQuantity.run(user_id, stock_symbol, :buy)
    end

    def sold_shares
      @sold_shares ||= Shares::CalculateHeldQuantity.run(user_id, stock_symbol, :sell)
    end
  end
end
