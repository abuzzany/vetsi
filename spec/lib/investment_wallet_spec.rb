# frozen_string_literal: true

require './spec/fixtures/transactions/transactions_mock'

RSpec.describe InvestmentWallet do
  include TransactionsMock

  describe '.call' do
    context 'for a existeng user' do
      it 'should returns the list of bought stocks' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)

        result = described_class.for(user.id).call

        expect(result[:stocks].count).to be_eql(2)
        expect(result[:stocks][0]['AAPL'][:profit_loss]).to be_eql(1711.3999999999999)
        expect(result[:stocks][0]['AAPL'][:held_shares]).to be_eql(10)
        expect(result[:stocks][1]['TSLA'][:profit_loss]).to be_eql(3730.28)
        expect(result[:stocks][1]['TSLA'][:held_shares]).to be_eql(4)
      end
    end
  end
end
