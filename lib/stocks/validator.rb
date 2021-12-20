# frozen_string_literal: true

module Stocks
  # This class validates a stock symbol in NASDAQ API.
  class Validator
    def self.call(stock_symbol)
      response = NasdaqClient::Api.new(stock_symbol).call

      return true if response['status']['rCode'] == 200

      false
    end
  end
end
