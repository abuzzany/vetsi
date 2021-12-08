ENV['APP_ENV'] = 'test'

require './lib/shares/buyer'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

RSpec.describe Shares::Buyer do
  include Rack::Test::Methods

  describe '.call' do
    context 'for an invalid stock symbol' do
      it 'should return a not found error when the symbol doe not exist' do
        result = described_class.call(:FAKEAPPL)
        puts result
        expect(result[:status]).to be_eql('success')
        expect(result[:code]).to be_eql(400)
      end
    end
  end
end
