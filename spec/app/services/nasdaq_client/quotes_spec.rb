# frozen_string_literal: true

require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe NasdaqClient::Quotes do
  include NasdaqApiStubs

  describe '.new' do
    context 'for a valid stock symbol' do
      before(:each) do
        allow(HTTParty).to receive(:get).and_return(valid_stock_symbol_response)
      end

      it 'creates an instance of NasdaqClient::Quotes' do
        expect(described_class.new(:AAPL)).to be_an_instance_of(NasdaqClient::Quotes)
      end

      it 'returns the stock information for a given stock symbol' do
        result = described_class.new(:AAPL)
        expect(result.symbol).to be_eql('AAPL')
        expect(result.company_name).to be_eql('Apple Inc. Common Stock')
        expect(result.last_sale_price).to be_eql(150.0)
      end
    end

    context 'for an invalid stock symbol' do
      before(:each) do
        allow(HTTParty).to receive(:get).and_return(invalid_stock_symbol_response)
      end

      it 'raises a NasdaqClient::QuoteException exception' do
        expect { described_class.new(:FAKEAAPL) }.to raise_error(NasdaqClient::QuoteException)
      end
    end
  end
end
