ENV['APP_ENV'] = 'test'

require './lib/nasdaq_client/api'  # <-- your sinatra app
require 'rspec'
require 'rack/test'
require 'httparty'

RSpec.describe NasdaqClient::Api do
  describe '.new' do
    context 'for a valid stock symbol' do
      it 'should creates an instance of NasdaqClient::Api' do
        result = described_class.new(:AAPL)
      end
    end
  end
end
