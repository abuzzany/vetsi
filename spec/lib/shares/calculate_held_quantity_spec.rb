# frozen_string_literal: true

require './spec/fixtures/transactions/transactions_mock'

RSpec.describe Shares::CalculateHeldQuantity do
  include TransactionsMock

  describe '.run' do
    context 'for a valid stock symbol' do
      it 'should returns tha calculated amount of holding shares' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)

        bought_shares = described_class.run(user.id, :AAPL, :buy)
        selled_share = described_class.run(user.id, :AAPL, :sell)

        expect(bought_shares).to be_eql(14)
        expect(selled_share).to be_eql(4)
      end
    end
  end
end
