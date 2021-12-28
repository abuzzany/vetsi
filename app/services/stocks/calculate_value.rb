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
      @today_range = Date.current.beginning_of_day..Date.current.end_of_day
    end

    def current_value
      total_shares = bought_shares_quantity - sold_shares_quantity
      total_shares * last_sale_price
    end

    def profit_loss
      (((current_value - bought_stock_value) / current_value) * 100).round(2)
    end

    def bought_shares_amount
      params = { user_id: user_id, transaction_type: :buy }

      @bought_shares_amount ||= perform_transaction_operarion(:sum, :total_amount, params)
    end

    def sold_shares_amount
      params = { user_id: user_id, transaction_type: :sell }

      @sold_shares_amount ||= perform_transaction_operarion(:sum, :total_amount, params)
    end

    def bought_shares_quantity
      params = { user_id: user_id, transaction_type: :buy }

      @bought_shares_quantity ||= perform_transaction_operarion(:sum, :share_quantity, params)
    end

    def sold_shares_quantity
      params = { user_id: user_id, transaction_type: :sell }

      @sold_shares_quantity ||= perform_transaction_operarion(:sum, :share_quantity, params)
    end

    def lowest_price
      @lowest_price ||= perfom_stock_operation(:minimum, :price, created_at: today_range)
    end

    def highest_price
      @highest_price ||= perfom_stock_operation(:maximum, :price, created_at: today_range)
    end

    def average_price
      @average_price ||= perfom_stock_operation(:average, :price, created_at: today_range)
    end

    private

    attr_accessor :today_range

    def bought_stock_value
      bought_shares_amount - sold_shares_amount
    end

    def perform_transaction_operarion(operation, field, params = {})
      params = {
        stock_symbol: stock_symbol
      }.merge(params)

      Transaction.where(params).send(operation, field).to_f
    end

    def perfom_stock_operation(operation, field, params = {})
      params = {
        stock_symbol: stock_symbol
      }.merge(params)

      StockPriceLog.where(params).send(operation, field).to_f
    end
  end
end
