module Shares
  # The goal of this service object is buy company shares
  class Buyer
    def self.call(user_id, stock_symbol, share_quantity)
      result = StockValidator.call(stock_symbol)

      return commit_transaction if result

      { status: 'success', code: 400 }
    end

    private

    def self.commit_transaction
      { status: 'success', code: 200 }
    end
  end
end
