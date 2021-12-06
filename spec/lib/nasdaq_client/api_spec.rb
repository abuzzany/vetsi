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
        expect(result).to be_an_instance_of(NasdaqClient::Api)
      end
    end
  end

  describe 'is_valid?' do
    context 'for a valid stock symbol' do
      it 'should creates an instance of NasdaqClient::Api' do
        result = described_class.new(:AAPL).is_valid?
        expect(result).to be_truthy
      end
    end
  end
end
