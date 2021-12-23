# frozen_string_literal: true

RSpec.describe NasdaqClient::Quotes do
  describe '.new' do
    context 'for a valid stock symbol' do
      it 'creates an instance of NasdaqClient::Quotes' do
        expect(described_class.new(:AAPL)).to be_an_instance_of(NasdaqClient::Quotes)
      end

      it 'returns the stock information for a given stock symbol' do
        result = described_class.new(:AAPL)
        expect(result.symbol).to be_eql('AAPL')
        expect(result.company_name).to be_eql('Apple Inc. Common Stock')
        expect(result.last_sale_price).to be_eql('$175.915')
      end
    end

    context 'for an invalid stock symbol' do
      it 'raises a NasdaqClient::QuoteException exception' do
        expect { described_class.new(:FAKEAAPL) }.to raise_error(NasdaqClient::QuoteException)
      end
    end
  end
end
