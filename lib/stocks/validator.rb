# frozen_string_literal: true

module Stocks
  # This class validates a stock symbol in NASDAQ API.
  class Validator
    def self.call(stock_symbol)
      NasdaqClient::Api.valid_stock_symbol?(stock_symbol)
    end
  end
end
