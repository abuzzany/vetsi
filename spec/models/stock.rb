# frozen_string_literal: true

RSpec.describe Stock do
  describe '.create' do
    context 'with all the required attributes' do
      it 'should persist a buy transaction' do
        stock = Stock.create(
          user_id: 1,
          stock_symbol: :AAPL,
          total_shares: 10
        )
        expect(stock.persisted?).to be_truthy
      end
    end
  end

  describe '.valid' do
    context 'with at least a missing required attribute' do
      it 'should returns false' do
        stock = Stock.new(
          user_id: 1
        )
        expect(stock.valid?).to be_falsy
      end
    end
  end
end
