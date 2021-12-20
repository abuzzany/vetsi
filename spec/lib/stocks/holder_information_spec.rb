# frozen_string_literal: true

require './spec/fixtures/transactions/transactions_mock'

RSpec.describe Stocks::HolderInformation do
  include TransactionsMock

  describe '.stocks' do
    context 'for a existeng user' do
      it 'should returns the list of bought stocks' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)

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
