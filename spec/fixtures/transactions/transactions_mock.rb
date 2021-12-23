# frozen_string_literal: true

module TransactionsMock
  def create_transactions(user_id)
    Transaction.create(user_id: user_id,
                       transaction_type: :buy,
                       stock_symbol: :AAPL,
                       share_quantity: 10,
                       share_price: 120,
                       total_amount: 10 * 120)

    Transaction.create(user_id: user_id,
                       transaction_type: :buy,
                       stock_symbol: :AAPL,
                       share_quantity: 4,
                       share_price: 300,
                       total_amount: 4 * 300)

    Transaction.create(user_id: user_id,
                       transaction_type: :sell,
                       stock_symbol: :AAPL,
                       share_quantity: 4,
                       share_price: 120,
                       total_amount: 4 * 120)

    Transaction.create(user_id: user_id,
                       transaction_type: :buy,
                       stock_symbol: :TSLA,
                       share_quantity: 5,
                       share_price: 90,
                       total_amount: 5 * 90)
  end
end
