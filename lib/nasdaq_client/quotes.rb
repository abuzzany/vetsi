# frozen_string_literal: true

module NasdaqClient
  # This class returns the information for a given
  # stock symbol.
  class Quotes
    attr_accessor :stock_symbol,
                  :api

    def initialize(stock_symbol)
      @stock_symbol = stock_symbol
      @api = NasdaqClient::Api.new(stock_symbol).call
    end

    def info
      api.call
    end

    def symbol
      response_data['symbol']
    end

    def company_name
      response_data['companyName']
    end

    def last_sale_price
      response_data['primaryData']['lastSalePrice']
    end

    private

    def response_data
      api['data']
    end
  end
end
