# frozen_string_literal: true

module Stocks
  # This service validates a stock symbol in NASDAQ API.
  class Validator
    def self.call(stock_symbol)
      NasdaqClient::Quotes.new(stock_symbol)
      true
    rescue NasdaqClient::QuoteException
      false
    end
  end
end
