# frozen_string_literal: true

require './spec/fixtures/transactions/transactions_mock'
require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe InvestmentWallet do
  include TransactionsMock
  include NasdaqApiStubs

  describe '.call' do
    before(:each) do
      allow(HTTParty).to receive(:get).and_return(valid_stock_symbol_response)
    end

    context 'for an existent user' do
      it 'returns its investment wallet' do
        user = User.create(email: 'abuzzany@gmail.com')

        # AAPL buy, 10 * $120 = $1,200
        # AAPL buy, 4 * $300 = $1200
        # AAPL sell, 4 * $120 = $480
        # AAPL = 10 shares
        # TSLA buy, 5 * $200 = 1,000 shares
        # Mocked last_sales price $150
        create_transactions(user.id)

        result = described_class.for(user.id).call

        expect(result.success?).to be_truthy
        expect(result.payload[:user_id]).to be_eql(user.id)
        expect(result.payload[:stocks].count).to be_eql(2)
        expect(result.payload[:stocks][0][:stock_symbol]).to be_eql('AAPL')
        expect(result.payload[:stocks][0][:profit_loss]).to be_eql(-28.0)
        expect(result.payload[:stocks][0][:held_shares]).to be_eql(10)
        expect(result.payload[:stocks][0][:current_stock_value]).to be_eql(1500.0)
        expect(result.payload[:stocks][1][:stock_symbol]).to be_eql('TSLA')
        expect(result.payload[:stocks][1][:profit_loss]).to be_eql(40.0)
        expect(result.payload[:stocks][1][:held_shares]).to be_eql(5)
        expect(result.payload[:stocks][1][:current_stock_value]).to be_eql(750.0)
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
