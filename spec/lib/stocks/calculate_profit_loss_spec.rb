# frozen_string_literal: true

RSpec.describe Stocks::CalculateProfitLoss do
  describe '.run' do
    context 'for a valid stock symbol' do
      it 'should calculates the profit or loss amount' do
        user = User.create(email: 'abuzzany@gmail.com')

        Transaction.create(user_id: user.id,
                           transaction_type: :buy,
                           stock_symbol: :AAPL,
                           share_quantity: 10,
                           share_price: 150_000,
                           total_amount: 10 * 150_000)

        Transaction.create(user_id: user.id,
                           transaction_type: :buy,
                           stock_symbol: :AAPL,
                           share_quantity: 4,
                           share_price: 50_000,
                           total_amount: 4 * 50_000)

        Transaction.create(user_id: user.id,
                           transaction_type: :sell,
                           stock_symbol: :AAPL,
                           share_quantity: 4,
                           share_price: 10_000,
                           total_amount: 4 * 10_000)

        result = described_class.run(user.id, :AAPL)
        expect(result).to be_eql(1711.3999999999999)
      end
    end
  end
end
