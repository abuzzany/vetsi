ENV['APP_ENV'] = 'test'

require 'rspec'
require 'rack/test'

RSpec.describe Shares::Buyer do
  include Rack::Test::Methods

  describe '.call' do
    context 'for an invalid stock symbol' do
      it 'should returns a not found error when the symbol doe not exist' do
        user = User.create(email: 'abuzzany@gmail.com')
        share_quantity = 5
        result = described_class.call(user.id, :FAKEAPPL, share_quantity)
        expect(result[:status]).to be_eql('success')
        expect(result[:code]).to eql(400)
      end
    end

    context 'for a valid stock symbol' do
      it 'should returns the transaction detail for the share bought' do
        user = User.create(email: 'abuzzany@gmail.com')
        result = described_class.call(user.id, :AAPL, 10)
        expect(result[:status]).to be_eql('success')
        expect(result[:code]).to eql(200)
      end
    end
  end
end
