# frozen_string_literal: true

module Shares
  # The goal of this service object is buy company shares
  class Buyer
    attr_accessor :user_id,
                  :stock_symbol,
                  :share_quantity

    def self.call(user_id, stock_symbol, share_quantity)
      new(user_id, stock_symbol, share_quantity).call
    end

    def initialize(user_id, stock_symbol, share_quantity)
      @user_id = user_id
      @stock_symbol = stock_symbol
      @share_quantity = share_quantity
    end

    def call
      result = Stocks::Validator.call(stock_symbol)

      if result
        last_sale_price = Stocks::Info.new(stock_symbol).last_sale_price

        return commit_transaction(last_sale_price)
      end

      { status: 'success', code: 400 }
    end

    private

    def commit_transaction(share_price)
      transaction = Transaction.create(user_id: user_id,
                                       transaction_type: :buy,
                                       share_quantity: share_quantity,
                                       share_price: share_price)

      return { status: 'success', code: 200 } if transaction.persisted?
    end
  end
end
