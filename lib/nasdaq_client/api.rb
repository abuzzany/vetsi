require 'httparty'

# This class works as a NASDAQ API client
module NasdaqClient
  class Api
    def self.valid_stock_symbol?(stock_symbol)
      query = {
        "assetclass": 'stocks'
      }

      headers = {
        "User-Agent": 'PostmanRuntime/7.28.4',
        "Accept": '*/*'

      }

      response = HTTParty.get(
        "https://api.nasdaq.com/api/quote/#{stock_symbol}/info",
        headers: headers,
        query: query
      )

      return true if response["status"]["rCode"] == 200

      false
    end
  end
end
