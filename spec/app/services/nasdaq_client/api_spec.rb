# frozen_string_literal: true

require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe NasdaqClient::Api do
  include NasdaqApiStubs

  describe '.new' do
    context 'for a valid stock symbol' do
      before(:each) do
        allow(HTTParty).to receive(:get).and_return(valid_stock_symbol_response)
      end

      it 'creates an instance of NasdaqClient::Api' do
        expect(described_class.new).to be_an_instance_of(NasdaqClient::Api)
      end

      it 'returns the stock information for a given symbol' do
        response = described_class.new.get('quote/AAPL/info')

        expect(response['status']['rCode']).to be_eql(200)
        expect(response['data']['symbol']).to be_eql('AAPL')
        expect(response['data']['companyName']).to be_eql('Apple Inc. Common Stock')
        expect(response['data']['primaryData']['lastSalePrice']).to be_eql('$150.00')
      end
    end

    context 'for a invalid stock symbol' do
      before do
        allow(HTTParty).to receive(:get).and_return(invalid_stock_symbol_response)
      end

      it 'returns error code 400' do
        response = described_class.new.get('quote/FAKEAAPL/info')
        expect(response['status']['rCode']).to be_eql(400)
      end
    end
  end
end
