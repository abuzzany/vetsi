# frozen_string_literal: true

class StockPriceLog < ActiveRecord::Base
  validates_presence_of :stock_symbol,
                        :price
end
