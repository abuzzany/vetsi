module Shares
  # The goal of this service object is buy company shares
  class Buyer
    def self.call(stock_symbol)
      { status: 'success', code: 400 }
    end
  end
end
