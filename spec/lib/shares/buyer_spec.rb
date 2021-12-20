# frozen_string_literal: true

RSpec.describe Shares::Buyer do
  describe '.call' do
    context 'for an invalid stock symbol' do
      it 'should returns a not found error when the symbol doe not exist' do
        user = User.create(email: 'abuzzany@gmail.com')

        share_quantity = 5

        result = described_class.call(user.id, :FAKEAPPL, share_quantity, :buy)
        expect(result[:status]).to be_eql('success')
        expect(result[:code]).to eql(400)
        expect(result[:transaction]).to be_nil
      end
    end

    context 'for a valid stock symbol' do
      it 'should returns the transaction detail for the share bought' do
        user = User.create(email: 'abuzzany@gmail.com')

        share_quantity = 5

        result = described_class.call(user.id, :AAPL, share_quantity, :buy)

        expect(result[:status]).to be_eql('success')
        expect(result[:code]).to be_eql(200)
        expect(result[:transaction].user_id).to be_eql(user.id)
        expect(result[:transaction].transaction_type).to be_eql('buy')
        expect(result[:transaction].stock_symbol).to be_eql('AAPL')
        expect(result[:transaction].share_quantity).to be_eql(5)
        expect(result[:transaction].share_price).to be_eql(171.14)
        expect(result[:transaction].total_amount).to be_eql(855.6999999999999)
      end
    end
  end
end
