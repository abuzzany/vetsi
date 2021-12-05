ENV['APP_ENV'] = 'test'

require './lib/stock_validator'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

RSpec.describe StockValidator do
  include Rack::Test::Methods

    describe ".call" do
        context 'for a valid stock symbol' do

            it 'should return true when the symbol exists' do
                result = described_class.call(:AAPL)
                expect(result).to be_truthy
            end

        end
    end

end
