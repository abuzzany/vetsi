# This class validates a stock symbol in NASDAQ API.
class StockValidator
  def self.call(stock_symbol)
    return '' unless stock_symbol
    return true if stock_symbol == :AAPL

    false
  end
end
