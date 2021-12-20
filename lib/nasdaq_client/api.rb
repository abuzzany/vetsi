# frozen_string_literal: true

require 'httparty'

# This class works as a NASDAQ API client
module NasdaqClient
  # This class works as an interface to make request to
  # NASDAQ API.
  class Api
    attr_reader :stock_symbol

    def initialize(stock_symbol)
      @stock_symbol = stock_symbol
    end

    def call
      HTTParty.get(
        "https://api.nasdaq.com/api/quote/#{stock_symbol}/info",
        headers: headers,
        query: query
      )
    end

    def headers
      # This heades is necessary because nasdaq api
      # blocks request for web scraping
      {
        "User-Agent": 'PostmanRuntime/7.28.4',
        "Accept": '*/*'
      }
    end

    def query
      {
        "assetclass": 'stocks'
      }
    end
  end
end
