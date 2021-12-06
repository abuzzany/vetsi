ENV['APP_ENV'] = 'test'

require './lib/nasdaq_client/api'  # <-- your sinatra app
require 'rspec'
require 'rack/test'
require 'httparty'

RSpec.describe NasdaqClient::Api do
  describe '.new' do
    context 'for a valid stock symbol' do
      it 'should creates an instance of NasdaqClient::Api' do
        result = described_class.new
        expect(result).to be_an_instance_of(NasdaqClient::Api)
      end
    end
  end

  describe '.valid_stock_symbol?' do
    context 'for a valid stock symbol' do
      it 'shuld returns true' do
        result = described_class.valid_stock_symbol?(:AAPL)
        expect(result).to be_truthy
      end
    end

    context 'for a ivalid stock symbol' do
      it 'shuld returns false' do
        result = described_class.valid_stock_symbol?(:FAKE)
        expect(result).to be_falsy
      end
    end
  end
end
