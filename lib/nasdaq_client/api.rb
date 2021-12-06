require 'httparty'

module NasdaqClient
  class Api
    include HTTParty

    base_uri 'https://api.nasdaq.com/api/quote/'

    attr_accessor :stock_symbol

    def initialize(stock_symbol)
      @stock_symbol = stock_symbol
    end
  end
end
