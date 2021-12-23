# frozen_string_literal: true

module NasdaqClient
  # This class returns the information for a given
  # stock symbol.
  class Quotes
    attr_accessor :stock_symbol,
                  :api

    def initialize(stock_symbol)
      @stock_symbol = stock_symbol
      @api = NasdaqClient::Api.new(stock_symbol)
    end

    def info
      api.call
    end
  end
end
