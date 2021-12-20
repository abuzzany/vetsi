# frozen_string_literal: true

RSpec.describe Stocks::CalculateStockQuantity do
  describe '.run' do
    context 'for a valid stock symbol' do
      it 'should returns tha calculated amount of holding shares' do
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

        bought_shares = described_class.run(user.id, :AAPL, :buy)
        selled_share = described_class.run(user.id, :AAPL, :sell)

        expect(bought_shares).to be_eql(14)
        expect(selled_share).to be_eql(4)
      end
    end
  end
end
