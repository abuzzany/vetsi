# frozen_string_literal: true

module Stocks
  # This service calculates the value of a user stock, for example
  # the profit or loss of a stock, the current value etc.
  class CalculateValue
    attr_accessor :user_id,
                  :stock_symbol,
                  :last_sale_price

    def self.for(user_id, stock_symbol)
      new(user_id, stock_symbol)
    end

    def initialize(user_id, stock_symbol)
      @user_id = user_id
      @stock_symbol = stock_symbol
      @last_sale_price = NasdaqClient::Quotes.new(stock_symbol).last_sale_price
    end

    def current_value
      total_shares = bought_shares_quantity - sold_shares_quantity
      total_shares * last_sale_price
    end

    def profit_loss
      (((current_value - bought_stock_value) / current_value) * 100).round(2)
    end

    def bought_shares_amount
      @bought_shares_amount ||= perform_sum(:buy, :total_amount)
    end

    def sold_shares_amount
      @sold_shares_amount ||= perform_sum(:sell, :total_amount)
    end

    def bought_shares_quantity
      @bought_shares_quantity ||= perform_sum(:buy, :share_quantity)
    end

    def sold_shares_quantity
      @sold_shares_quantity ||= perform_sum(:sell, :share_quantity)
    end

    private

    def bought_stock_value
      bought_shares_amount - sold_shares_amount
    end

    def perform_sum(transaction_type, field)
      Transaction.where(
        user_id: user_id,
        transaction_type: transaction_type,
        stock_symbol: stock_symbol
      ).sum(field)
    end
  end
end
