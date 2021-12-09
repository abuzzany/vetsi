module Shares
  # The goal of this service object is buy company shares
  class Buyer
    def self.call(user_id, stock_symbol, share_quantity)
      result = StockValidator.call(stock_symbol)

      return { status: 'success', code: 200 } if result

      { status: 'success', code: 400 }
    end
  end
end
