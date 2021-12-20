# frozen_string_literal: true

module Stocks
  # This class returns the stock information for a given time.
  class Info
    attr_reader :stock_symbol,
                :result

    def initialize(stock_symbol)
      @stock_symbol = stock_symbol

      call
    end

    def last_sale_price
      parse_last_sale_price
    end

    private

    def call
      @result = NasdaqClient::Api.new(stock_symbol).call
    end

    # The format of lastSalePrice attribute comes from
    # NASDAQ API and contains the symbol '$', this method
    # Removes and parse the attribute.
    def parse_last_sale_price
      price = result['data']['primaryData']['lastSalePrice']
      price.delete!('$')
      price.to_f
    end
  end
end
