# frozen_string_literal: true

module Stocks
  # This class returnt the information of a bought share.
  class HolderInformation
    attr_reader :user

    def initialize(user_id)
      @user = User.find(user_id)
    end

    def stocks
      Transaction.select(:stock_symbol).where(user_id: user.id).distinct.map do |transaction|
        { transaction.stock_symbol => { 
                                        profit_loss: Stocks::CalculateProfitLoss.run(user.id, transaction.stock_symbol),
                                        held_shares: Stocks::CalculateStockQuantity.run(user.id, transaction.stock_symbol, :buy) -  Stocks::CalculateStockQuantity.run(user.id, transaction.stock_symbol, :sell) 
                                      } 
        }
      end
    end
  end
end
