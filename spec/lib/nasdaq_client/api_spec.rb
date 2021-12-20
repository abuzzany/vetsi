# frozen_string_literal: true

RSpec.describe NasdaqClient::Api do
  describe '.new' do
    context 'for a valid stock symbol' do
      it 'should creates an instance of NasdaqClient::Api' do
        result = described_class.new(:AAPL)
        expect(result).to be_an_instance_of(NasdaqClient::Api)
      end

      it 'should returns the stock info for a given symbol' do
        result = described_class.new(:AAPL).call
        expect(result['status']['rCode']).to be_eql(200)
        expect(result['data']['symbol']).to be_eql('AAPL')
        expect(result['data']['companyName']).to be_eql('Apple Inc. Common Stock')
      end
    end
  end
end
