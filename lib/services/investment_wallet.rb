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
      {
        stock_symbol: transaction.stock_symbol,
        profit_loss: Stocks::CalculateProfitLoss.run(user_id, transaction.stock_symbol),
        held_shares: calculate_held_shares(user_id, transaction.stock_symbol)
      }
    end
  end

  def calculate_held_shares(user_id, stock_symbol)
    Shares::CalculateHeldQuantity.run(user_id, stock_symbol, :buy) -
      Shares::CalculateHeldQuantity.run(user_id, stock_symbol, :sell)
  end

  def run_checks
    return OpenStruct.new(success?: false, message: "user_id can't be nil") unless user_id
    return OpenStruct.new(success?: false, message: "User doesn't exist") unless User.exists?(user_id)

    OpenStruct.new(success?: true)
  end
end
