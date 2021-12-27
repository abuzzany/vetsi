# frozen_string_literal: false

module StockPriceLogsMock
  def create_stock_price_logs
    (1..23).each do |hour|
      date = DateTime.new(2021, Date.current.month, Date.current.day, hour, 59, 59).to_s
      aapl_stock_price_log = StockPriceLog.find_or_initialize_by(stock_symbol: :AAPL, created_at: date)
      aapl_stock_price_log.price = Random.rand(100..200)
      aapl_stock_price_log.save

      tsla_stock_price_log = StockPriceLog.find_or_initialize_by(stock_symbol: :TSLA, created_at: date)
      tsla_stock_price_log.price = Random.rand(100..200)
      tsla_stock_price_log.save
    end
  end
end
