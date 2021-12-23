# frozen_string_literal: true

require 'rack/test'
require './spec/fixtures/transactions/transactions_mock'

RSpec.describe 'App' do
  include Rack::Test::Methods
  include TransactionsMock

  def app
    Sinatra::Application
  end

  describe '#users#wallet' do
    context 'for an existing user' do
      it 'returns the detail of the stock bought' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)

        get "api/v1/users/#{user.id}/wallet"

        response = JSON.parse(last_response.body)

        expect(last_response).to be_ok
        expect(response['user_id']).to be_eql(user.id.to_s)
        expect(response['stocks'].count).to be_eql(2)
        expect(response['stocks'].count).to be_eql(2)
        expect(response['stocks'][0]['stock_symbol']).to be_eql('AAPL')
        expect(response['stocks'][0]['profit_loss']).to be_eql(1756.3999999999999)
        expect(response['stocks'][0]['held_shares']).to be_eql(10)
        expect(response['stocks'][1]['stock_symbol']).to be_eql('TSLA')
        expect(response['stocks'][1]['profit_loss']).to be_eql(4035.48)
        expect(response['stocks'][1]['held_shares']).to be_eql(4)
      end
    end
  end

  describe '#users#stocks#buy' do
    context 'for a valid stock symbol' do
      it 'returns the detail of the stock share bought' do
        user = User.create(email: 'abuzzany@gmail.com')

        params = {
          stock_symbol: 'AAPL',
          share_quantity: 10
        }

        post "api/v1/users/#{user.id}/stocks/buy", params.to_json

        response = JSON.parse(last_response.body)

        expect(last_response).to be_ok
        expect(response['user_id']).to be_eql(user.id)
        expect(response['transaction_type']).to be_eql('buy')
        expect(response['stock_symbol']).to be_eql('AAPL')
        expect(response['share_quantity']).to be_eql(10)
        expect(response['total_amount']).to be_eql(1756.3999999999999)
      end
    end
  end
end
