# frozen_string_literal: true

require 'httparty'

# This class works as a NASDAQ API client
module NasdaqClient
  # This class works as an interface to make request to
  # NASDAQ API.
  class Api
    BASE_URL = 'https://api.nasdaq.com/api'

    attr_accessor :response

    def get(path)
      HTTParty.get("#{BASE_URL}/#{path}", headers: headers, query: query)
    end

    private

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
