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

      it 'should calculates the profit or loss amount' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)

        result = described_class.run(user.id, :AAPL)

        expect(result).to be_eql(1500.0)
      end
    end
  end
end
