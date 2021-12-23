# frozen_string_literal: true

RSpec.describe Stocks::Validator do
  describe '.call' do
    context 'for a valid stock symbol' do
      it 'returns true when the symbol exists' do
        result = described_class.call(:AAPL)
        expect(result).to be_truthy
      end

      it 'returns false when the symbol does not exist' do
        result = described_class.call(:FAEKAAPL)
        expect(result).to be_falsy
      end
    end
  end
end
