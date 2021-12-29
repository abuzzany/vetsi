# frozen_string_literal: true
require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe Stocks::Validator do
  include NasdaqApiStubs

  describe '.call' do
    context 'for a valid stock symbol' do
      it 'returns true when the symbol exists' do
        allow(HTTParty).to receive(:get).and_return(valid_stock_symbol_response)

        result = described_class.call(:AAPL)
        expect(result).to be_truthy
      end

      it 'returns false when the symbol does not exist' do
        allow(HTTParty).to receive(:get).and_return(invalid_stock_symbol_response)

        result = described_class.call(:FAEKAAPL)
        expect(result).to be_falsy
      end
    end
  end
end
