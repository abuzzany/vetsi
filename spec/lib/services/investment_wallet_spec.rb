# frozen_string_literal: true

require './spec/fixtures/transactions/transactions_mock'

RSpec.describe InvestmentWallet do
  include TransactionsMock

  describe '.call' do
    context 'for an existing user' do
      it 'returns its investment wallet' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)

        result = described_class.for(user.id).call

        expect(result[:user_id]).to be_eql(user.id)
        expect(result[:stocks].count).to be_eql(2)
        expect(result[:stocks][0][:stock_symbol]).to be_eql('AAPL')
        expect(result[:stocks][0][:profit_loss]).to be_eql(1711.3999999999999)
        expect(result[:stocks][0][:held_shares]).to be_eql(10)
        expect(result[:stocks][1][:stock_symbol]).to be_eql('TSLA')
        expect(result[:stocks][1][:profit_loss]).to be_eql(3730.28)
        expect(result[:stocks][1][:held_shares]).to be_eql(4)
      end
    end
  end
end
