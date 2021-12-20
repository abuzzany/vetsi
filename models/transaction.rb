class Transaction < ActiveRecord::Base
  validates_presence_of :user_id,
                        :transaction_type,
                        :stock_symbol,
                        :share_quantity,
                        :share_price

  enum transaction_type: { sell: 0, buy: 1 }

  def profit_loss
    bought_price = share_price
    current_value = Stocks::Info.new(:AAPL).last_sale_price

    current_value - bought_price
  end
end
