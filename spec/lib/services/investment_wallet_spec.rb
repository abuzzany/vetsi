# frozen_string_literal: true

require './spec/fixtures/transactions/transactions_mock'

RSpec.describe InvestmentWallet do
  include TransactionsMock

  describe '.call' do
    context 'for an existent user' do
      it 'returns its investment wallet' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)

        result = described_class.for(user.id).call

        expect(result.success?).to be_truthy
        expect(result.payload[:user_id]).to be_eql(user.id)
        expect(result.payload[:stocks].count).to be_eql(2)
        expect(result.payload[:stocks][0][:stock_symbol]).to be_eql('AAPL')
        expect(result.payload[:stocks][0][:profit_loss]).to be_eql(1756.3999999999999)
        expect(result.payload[:stocks][0][:held_shares]).to be_eql(10)
        expect(result.payload[:stocks][1][:stock_symbol]).to be_eql('TSLA')
        expect(result.payload[:stocks][1][:profit_loss]).to be_eql(4035.48)
        expect(result.payload[:stocks][1][:held_shares]).to be_eql(4)
      end
    end

    context 'for an inexistent user' do
      it 'returns an message error' do
        user = User.create(email: 'abuzzany@gmail.com')
        user.delete

        result = described_class.for(user.id).call

        expect(result.success?).to be_falsy
        expect(result.message).to be_eql("User doesn't exist")
      end
    end

    context 'without user_id param' do
      it 'returns an message error' do
        user_id = nil

        result = described_class.for(user_id).call

        expect(result.success?).to be_falsy
        expect(result.message).to be_eql("user_id can't be nil")
      end
    end
  end
end
