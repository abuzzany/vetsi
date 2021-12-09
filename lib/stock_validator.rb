# This class validates a stock symbol in NASDAQ API.
class StockValidator
  def self.call(stock_symbol)
    NasdaqClient::Api.valid_stock_symbol?(stock_symbol)
  end
end
