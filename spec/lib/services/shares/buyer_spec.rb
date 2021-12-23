# frozen_string_literal: true

RSpec.describe Shares::Buyer do
  describe '.call' do
    context 'for an invalid stock symbol' do
      it 'returns an error message' do
        user = User.create(email: 'abuzzany@gmail.com')

        share_quantity = 5

        result = described_class.call(user.id, :FAKEAPPL, share_quantity, :buy)

        expect(result.success?).to be_falsy
        expect(result.code).to eql(400)
      end
    end

    context 'for an inexistent user' do
      it 'returns an error message' do
        user = User.create(email: 'abuzzany@gmail.com')
        user.delete

        share_quantity = 5

        result = described_class.call(user.id, :AAPL, share_quantity, :buy)

        expect(result.success?).to be_falsy
        expect(result.message).to be_eql("User doesn't exist")
      end
    end

    context 'for a valid stock symbol' do
      it 'returns the transaction detail for the bought share' do
        user = User.create(email: 'abuzzany@gmail.com')

        share_quantity = 5

        result = described_class.call(user.id, :AAPL, share_quantity, :buy)

        expect(result.success?).to be_truthy
        expect(result.payload.user_id).to be_eql(user.id)
        expect(result.payload.transaction_type).to be_eql('buy')
        expect(result.payload.stock_symbol).to be_eql('AAPL')
        expect(result.payload.share_quantity).to be_eql(5)
        expect(result.payload.share_price).to be_eql(175.64)
        expect(result.payload.total_amount).to be_eql(878.1999999999999)
      end
    end
  end
end
