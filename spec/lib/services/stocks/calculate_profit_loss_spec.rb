# frozen_string_literal: true

require './spec/fixtures/transactions/transactions_mock'
require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe Stocks::CalculateProfitLoss do
  include TransactionsMock
  include NasdaqApiStubs

  describe '.run' do
    context 'for a valid stock symbol' do
      before(:each) do
        allow(HTTParty).to receive(:get).and_return(valid_stock_symbol_response)
      end

      it 'calculates the profit or loss percentage' do
        user = User.create(email: 'abuzzany@gmail.com')

        # AAPL buy, 10 * $120 = 1,200 shares
        # AAPL buy, 4 * $122 = 488 shares
        # AAPL sell, 4 * $120 = 1,200 shares
        # AAPL = 10 shares
        # TSLA buy, 5 * $200 = 1,000 shares
        # Mocked last_sales price $150
        create_transactions(user.id)

        result = described_class.run(user.id, :AAPL)

        expect(result).to be_eql(1500.0)
      end
    end
  end
end
