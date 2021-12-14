module Shares
  # The goal of this service object is buy company shares
  class Buyer
    attr_accessor :user_id,
                  :stock_symbol,
                  :share_quantity

    def initialize(user_id, stock_symbol, share_quantity)
      @user_id = user_id
      @stock_symbol = stock_symbol
      @share_quantity = share_quantity
    end

    def self.call(user_id, stock_symbol, share_quantity)
      new(user_id, stock_symbol, share_quantity).call
    end

    def call
      result = StockValidator.call(stock_symbol)

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
                                       share_price: share_price_to_cents(share_price))

      calculate_user_stock_value

      return { status: 'success', code: 200 } if transaction.persisted?
    end

    # To avoid problemes with float point operations,
    # the share_price is saved in cents format.
    def share_price_to_cents(share_price)
      share_price * 100
    end

    def calculate_user_stock_value
      user_stock  = Stock.find_or_initialize_by(
        user_id: user_id,
        stock_symbol: stock_symbol
      )

      user_stock.total_shares += share_quantity
      user_stock.save
    end
  end
end
