# frozen_string_literal: true

require 'httparty'

module NasdaqClient
  # This class uses HTTParty gem in order to make request to
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
