RSpec.describe Stocks::Info do
  describe '.new' do
    context 'for an invalid stock symbol' do
      it 'should returns a not found error when the symbol doe not exist' do
        described_class.new(:FAKEAPPL)
      end
    end
  end

  describe '.last_sale_price' do
    context 'for a valid stock symbol' do
      it 'should returns the last sale price' do
        stock_info = described_class.new(:AAPL)
        expect(stock_info.last_sale_price).to be_eql(171.14)
      end
    end
  end
end
