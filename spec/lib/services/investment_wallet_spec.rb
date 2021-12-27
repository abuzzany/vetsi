# frozen_string_literal: true

require './spec/fixtures/transactions/transactions_mock'
require './spec/fixtures/stock_price_logs/stock_price_logs_mock'
require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe InvestmentWallet do
  include TransactionsMock
  include StockPriceLogsMock
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
        create_stock_price_logs

        aapl_lowest_price = StockPriceLog.where(
          stock_symbol: :AAPL,
          created_at: Date.current.beginning_of_day..Date.current.end_of_day
        ).minimum(:price)

        aapl_highest_price = StockPriceLog.where(
          stock_symbol: :AAPL,
          created_at: Date.current.beginning_of_day..Date.current.end_of_day
        ).maximum(:price)

        tsla_lowest_price = StockPriceLog.where(
          stock_symbol: :TSLA,
          created_at: Date.current.beginning_of_day..Date.current.end_of_day
        ).minimum(:price)

        tsla_highst_price = StockPriceLog.where(
          stock_symbol: :TSLA,
          created_at: Date.current.beginning_of_day..Date.current.end_of_day
        ).maximum(:price)

        result = described_class.for(user.id).call

        expect(result.success?).to be_truthy
        expect(result.payload[:user_id]).to be_eql(user.id)
        expect(result.payload[:stocks].count).to be_eql(2)
        expect(result.payload[:stocks][0][:stock_symbol]).to be_eql('AAPL')
        expect(result.payload[:stocks][0][:profit_loss]).to be_eql(-28.0)
        expect(result.payload[:stocks][0][:held_shares]).to be_eql(10)
        expect(result.payload[:stocks][0][:current_stock_value]).to be_eql(1500.0)
        expect(result.payload[:stocks][0][:highest_pice]).to be_eql(aapl_highest_price)
        expect(result.payload[:stocks][0][:lowest_price]).to be_eql(aapl_lowest_price)
        expect(result.payload[:stocks][1][:stock_symbol]).to be_eql('TSLA')
        expect(result.payload[:stocks][1][:profit_loss]).to be_eql(40.0)
        expect(result.payload[:stocks][1][:held_shares]).to be_eql(5)
        expect(result.payload[:stocks][1][:current_stock_value]).to be_eql(750.0)
        expect(result.payload[:stocks][1][:highest_pice]).to be_eql(tsla_highst_price)
        expect(result.payload[:stocks][1][:lowest_price]).to be_eql(tsla_lowest_price)
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
