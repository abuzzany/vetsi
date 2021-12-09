module Shares
  # The goal of this service object is buy company shares
  class Buyer
    def self.call(user_id, stock_symbol, share_quantity)
      result = StockValidator.call(stock_symbol)

      return commit_transaction(user_id, share_quantity, 10) if result

      { status: 'success', code: 400 }
    end

    private

    def self.commit_transaction(user_id, share_quantity, share_price)
      transaction = Transaction.create(user_id: user_id,
                                       transaction_type: :buy,
                                       share_quantity: share_quantity,
                                       share_price: share_price)

      return { status: 'success', code: 200 } if transaction.persisted?
    end
  end
end
