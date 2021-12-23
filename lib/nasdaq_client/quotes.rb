# frozen_string_literal: true

module NasdaqClient
  # This class returns the information for a given
  # stock symbol.
  class Quotes
    def initialize(stock_symbol)
      @response = NasdaqClient::Api.new.get("quote/#{stock_symbol}/info")

      raise NasdaqClient::QuoteException if response['status']['rCode'] == 400
    end

    def symbol
      response_data['symbol']
    end

    def company_name
      response_data['companyName']
    end

    def last_sale_price
      price = response_data['primaryData']['lastSalePrice']
      price.delete!('$')
      price.to_f
    end

    private

    attr_reader :response

    def response_data
      response['data']
    end
  end
end
