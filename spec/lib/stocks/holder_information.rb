RSpec.describe Stocks::HolderInformation do
  describe '.stocks' do
    context 'for a existeng user' do
      it 'should returns the list of bought stocks' do
        user = User.create(email: 'abuzzany@gmail.com')
        Transaction.create(user_id: user.id,
                           transaction_type: :buy,
                           share_quantity: 10,
                           share_price: 150_000)

        stocks = described_class.new(user.id).stocks

        expect(stocks.count).to be_eql(1)
      end
    end
  end
end
