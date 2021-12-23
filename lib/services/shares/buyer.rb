# frozen_string_literal: true

module Shares
  # The goal of this service object is buy company shares
  class Buyer
    attr_accessor :user_id,
                  :stock_symbol,
                  :share_quantity,
                  :transaction_type

    def self.call(user_id, stock_symbol, share_quantity, transaction_type)
      new(user_id, stock_symbol, share_quantity, transaction_type).call
    end

    def initialize(user_id, stock_symbol, share_quantity, transaction_type)
      @user_id = user_id
      @stock_symbol = stock_symbol
      @share_quantity = share_quantity
      @transaction_type = transaction_type
    end

    def call
      result = run_checks

      return result unless result.success?
      return commit_transaction if valid_stock_symbol?

      OpenStruct.new(success?: false, code: 400, message: "stock_symbol '#{stock_symbol}' not found")
    end

    private

    def commit_transaction
      last_sale_price = Stocks::Info.new(stock_symbol).last_sale_price

      transaction = Transaction.create(user_id: user_id,
                                       transaction_type: transaction_type,
                                       stock_symbol: stock_symbol,
                                       share_quantity: share_quantity,
                                       share_price: last_sale_price,
                                       total_amount: share_quantity * last_sale_price)

      OpenStruct.new(success?: true, payload: transaction) if transaction.persisted?
    end

    def valid_stock_symbol?
      Stocks::Validator.call(stock_symbol)
    end

    def run_checks
      return OpenStruct.new(success?: false, message: "user_id can't be nil") unless user_id
      return OpenStruct.new(success?: false, message: "stock_symbol can't be nil") unless stock_symbol
      return OpenStruct.new(success?: false, message: "share_quantity can't be nil") unless share_quantity
      return OpenStruct.new(success?: false, message: "transaction_type can't be nil") unless transaction_type

      OpenStruct.new(success?: true)
    end
  end
end
