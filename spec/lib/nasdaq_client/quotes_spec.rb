# frozen_string_literal: true

RSpec.describe NasdaqClient::Quotes do
  describe '.info' do
    context 'for a valid stock symbol' do
      it 'creates an instance of NasdaqClient::Quotes' do
        result = described_class.new(:AAPL)
        expect(result).to be_an_instance_of(NasdaqClient::Quotes)
      end

      it 'returns the stock information for a given symbol' do
        result = described_class.new(:AAPL).info
        expect(result['status']['rCode']).to be_eql(200)
        expect(result['data']['symbol']).to be_eql('AAPL')
        expect(result['data']['companyName']).to be_eql('Apple Inc. Common Stock')
      end
    end
  end
end
