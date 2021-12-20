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
      return commit_transaction if valid_stock_symbol?

      { status: 'success', code: 400, transaction: nil }
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

      return { status: 'success', code: 200, transaction: transaction } if transaction.persisted?
    end

    def valid_stock_symbol?
      Stocks::Validator.call(stock_symbol)
    end
  end
end
