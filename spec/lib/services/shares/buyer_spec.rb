# frozen_string_literal: true

RSpec.describe Shares::Buyer do
  describe '.call' do
    context 'for an invalid stock symbol' do
      it 'should returns a not found error when the symbol doe not exist' do
        user = User.create(email: 'abuzzany@gmail.com')

        share_quantity = 5

        result = described_class.call(user.id, :FAKEAPPL, share_quantity, :buy)

        expect(result[:success?]).to be_falsy
        expect(result[:code]).to eql(400)
      end
    end

    context 'for a valid stock symbol' do
      it 'should returns the transaction detail for the share bought' do
        user = User.create(email: 'abuzzany@gmail.com')

        share_quantity = 5

        result = described_class.call(user.id, :AAPL, share_quantity, :buy)

        expect(result[:success?]).to be_truthy
        expect(result[:payload].user_id).to be_eql(user.id)
        expect(result[:payload].transaction_type).to be_eql('buy')
        expect(result[:payload].stock_symbol).to be_eql('AAPL')
        expect(result[:payload].share_quantity).to be_eql(5)
        expect(result[:payload].share_price).to be_eql(175.81)
        expect(result[:payload].total_amount).to be_eql(879.05)
      end
    end
  end
end
