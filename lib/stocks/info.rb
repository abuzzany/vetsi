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
      result['data']['primaryData']['lastSalePrice']
    end

    private

    def call
        @result = NasdaqClient::Api.new(stock_symbol).call
    end
  end
end
