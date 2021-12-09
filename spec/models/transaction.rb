ENV['APP_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'httparty'

RSpec.describe Transaction do
  describe '.create' do
    context 'with all the required attributes' do
      it 'should persist a buy transaction' do
        transaction = Transaction.create(
          user_id: 1,
          transaction_type: :buy,
          share_quantity: 10,
          share_price: 50_000
        )
        expect(transaction.persisted?).to be_truthy
      end
    end
  end
end
