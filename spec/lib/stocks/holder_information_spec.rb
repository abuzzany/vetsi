# frozen_string_literal: true

RSpec.describe Stocks::HolderInformation do
  describe '.stocks' do
    context 'for a existeng user' do
      it 'should returns the list of bought stocks' do
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

        Transaction.create(user_id: user.id,
                           transaction_type: :buy,
                           stock_symbol: :TSLA,
                           share_quantity: 4,
                           share_price: 100,
                           total_amount: 4 * 10_00)

        result = described_class.new(user.id).stocks

        expect(result.count).to be_eql(2)
        expect(result[0]['AAPL'][:profit_loss]).to be_eql(1711.3999999999999)
        expect(result[0]['AAPL'][:held_shares]).to be_eql(10)
        expect(result[1]['TSLA'][:profit_loss]).to be_eql(3730.28)
        expect(result[1]['TSLA'][:held_shares]).to be_eql(4)
      end
    end
  end
end
