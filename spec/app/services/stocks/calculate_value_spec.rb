# frozen_string_literal: true

require './spec/fixtures/transactions/transactions_mock'
require './spec/fixtures/stock_price_logs/stock_price_logs_mock'
require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe Stocks::CalculateValue do
  include TransactionsMock
  include StockPriceLogsMock
  include NasdaqApiStubs

  describe '.run' do
    before(:each) do
      allow(HTTParty).to receive(:get).and_return(valid_stock_symbol_response)
    end

    context 'when a stock has lost value' do
      it 'calculates the percentage' do
        user = User.create(email: 'abuzzany@gmail.com')

        # AAPL buy, 10 * $120 = $1,200
        # AAPL buy, 4 * $300 = $1200
        # AAPL sell, 4 * $120 = $480
        # AAPL = 10 shares
        # TSLA buy, 5 * $200 = 1,000 shares
        # Mocked last_sales price $150
        create_transactions(user.id)

        result = described_class.for(user.id, :AAPL)

        expect(result.profit_loss).to be_eql(-28.0)
      end
    end

    context 'when a stock has gained value' do
      it 'calculates the percentage' do
        user = User.create(email: 'abuzzany@gmail.com')

        # AAPL buy, 10 * $120 = $1,200
        # AAPL buy, 4 * $300 = $1200
        # AAPL sell, 4 * $120 = $480
        # AAPL = 10 shares
        # TSLA buy, 5 * $200 = 1,000 shares
        # Mocked last_sales price $150
        create_transactions(user.id)

        result = described_class.for(user.id, :TSLA)

        expect(result.profit_loss).to be_eql(40.0)
      end
    end

    context 'for a valid user stock' do
      it 'calculates its current value' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)

        result = described_class.for(user.id, :TSLA)

        expect(result.current_value).to be_eql(750.0)
      end

      it 'calculates its lowest price' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)
        create_stock_price_logs

        lowest_price = StockPriceLog.where(
          stock_symbol: :AAPL,
          created_at: Date.current.beginning_of_day..Date.current.end_of_day
        ).minimum(:price)

        result = described_class.for(user.id, :AAPL)

        expect(result.lowest_price).to be_eql(lowest_price)
      end

      it 'calculates its highest price' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)
        create_stock_price_logs

        maximum_price = StockPriceLog.where(
          stock_symbol: :AAPL,
          created_at: Date.current.beginning_of_day..Date.current.end_of_day
        ).maximum(:price)

        result = described_class.for(user.id, :AAPL)

        expect(result.highest_price).to be_eql(maximum_price)
      end
    end
  end
end
