# frozen_string_literal: true

# This service returns the investment wallet for a given
# user.
class InvestmentWallet
  attr_accessor :user_id

  def self.for(user_id)
    new(user_id)
  end

  def initialize(user_id)
    @user_id = user_id
  end

  def call
    result = run_checks

    return result unless result.success?

    OpenStruct.new(success?: true, payload: wallet)
  end

  private

  def wallet
    {
      user_id: user_id,
      stocks: stocks
    }
  end

  def stocks
    Transaction.select(:stock_symbol).where(user_id: user_id).distinct.map do |transaction|
      stock_value = Stocks::CalculateValue.for(user_id, transaction.stock_symbol)
      {
        stock_symbol: transaction.stock_symbol,
        held_shares: stock_value.bought_shares_quantity - stock_value.sold_shares_quantity,
        current_stock_value: stock_value.current_value,
        profit_loss: stock_value.profit_loss,
        current_day_references_price: current_day_references_price(stock_value)
      }
    end
  end

  def current_day_references_price(stock_value)
    {
      lowest_price: stock_value.lowest_price,
      highest_price: stock_value.highest_price,
      average_price: stock_value.average_price
    }
  end

  def run_checks
    return OpenStruct.new(success?: false, code: 400, message: "user_id can't be nil") unless user_id
    return OpenStruct.new(success?: false, code: 400, message: "User doesn't exist") unless User.exists?(user_id)

    OpenStruct.new(success?: true)
  end
end
