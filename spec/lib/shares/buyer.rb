ENV['APP_ENV'] = 'test'

require 'rspec'
require 'rack/test'

RSpec.describe Shares::Buyer do
  include Rack::Test::Methods

  describe '.call' do
    context 'for an invalid stock symbol' do
      it 'should returns a not found error when the symbol doe not exist' do
        result = described_class.call(:FAKEAPPL)
        expect(result[:status]).to be_eql('success')
        expect(result[:code]).to eql(400)
      end
    end

    context 'for a valid stock symbol' do
        it 'should returns the transaction detail for the share bought' do
          result = described_class.call(:APPL)
          expect(result[:status]).to be_eql('success')
          expect(result[:code]).to eql(400)
        end
      end
  end
end
