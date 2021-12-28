# frozen_string_literal: true

require 'rack/test'
require './spec/fixtures/transactions/transactions_mock'
require './spec/fixtures/stock_price_logs/stock_price_logs_mock'
require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe 'Api/v1/trading' do
  include Rack::Test::Methods
  include TransactionsMock
  include StockPriceLogsMock
  include NasdaqApiStubs

  def app
    Vetsi
  end

  let(:user) { User.create(email: 'abuzzany@gmail.com') }

  let(:create_params) do
    params = {
      user_id: user.id,
      stock_symbol: 'AAPL',
      share_quantity: 10
    }
  end

  before(:each) do
    allow(HTTParty).to receive(:get).and_return(valid_stock_symbol_response)
  end

  describe 'POST' do
    context 'when a user buys shares' do
      it 'returns the detail of the bought share' do
        post 'api/v1/trading', create_params.merge(transaction_type: 'buy').to_json

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)

        expect(response['user_id']).to be_eql(user.id)
        expect(response['transaction_type']).to be_eql('buy')
        expect(response['stock_symbol']).to be_eql('AAPL')
        expect(response['share_quantity']).to be_eql(10)
        expect(response['total_amount']).to be_eql(1500.0)
      end
    end

    context 'when a user sells shares' do
      it 'returns the detail of the bought share' do
        post 'api/v1/trading', create_params.merge(transaction_type: 'sell').to_json

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)

        expect(response['user_id']).to be_eql(user.id)
        expect(response['transaction_type']).to be_eql('sell')
        expect(response['stock_symbol']).to be_eql('AAPL')
        expect(response['share_quantity']).to be_eql(10)
        expect(response['total_amount']).to be_eql(1500.0)
      end
    end
  end
end
