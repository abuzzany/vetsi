# frozen_string_literal: true

RSpec.describe NasdaqClient::Api do
  describe '.new' do
    context 'for a valid stock symbol' do
      it 'creates an instance of NasdaqClient::Api' do
        expect(described_class.new).to be_an_instance_of(NasdaqClient::Api)
      end

      it 'returns the stock information for a given symbol' do
        response = described_class.new.get('quote/AAPL/info')
        expect(response['status']['rCode']).to be_eql(200)
        expect(response['data']['symbol']).to be_eql('AAPL')
        expect(response['data']['companyName']).to be_eql('Apple Inc. Common Stock')
      end
    end

    context 'for a invalid stock symbol' do
      it 'returns error code 400' do
        response = described_class.new.get('quote/FAKEAAPL/info')
        expect(response['status']['rCode']).to be_eql(400)
      end
    end
  end
end
