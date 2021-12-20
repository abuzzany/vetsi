# frozen_string_literal: true

module TransactionsMock
  def create_transactions(user_id)
    Transaction.create(user_id: user_id,
                       transaction_type: :buy,
                       stock_symbol: :AAPL,
                       share_quantity: 10,
                       share_price: 150_000,
                       total_amount: 10 * 150_000)

    Transaction.create(user_id: user_id,
                       transaction_type: :buy,
                       stock_symbol: :AAPL,
                       share_quantity: 4,
                       share_price: 50_000,
                       total_amount: 4 * 50_000)

    Transaction.create(user_id: user_id,
                       transaction_type: :sell,
                       stock_symbol: :AAPL,
                       share_quantity: 4,
                       share_price: 10_000,
                       total_amount: 4 * 10_000)

    Transaction.create(user_id: user_id,
                       transaction_type: :buy,
                       stock_symbol: :TSLA,
                       share_quantity: 4,
                       share_price: 100,
                       total_amount: 4 * 10_00)
  end
end
