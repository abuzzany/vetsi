# frozen_string_literal: true

require 'rack/test'
require './spec/fixtures/transactions/transactions_mock'
require './spec/fixtures/stock_price_logs/stock_price_logs_mock'
require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe 'App' do
  include Rack::Test::Methods
  include TransactionsMock
  include StockPriceLogsMock
  include NasdaqApiStubs

  def app
    Sinatra::Application
  end

  before(:each) do
    allow(HTTParty).to receive(:get).and_return(valid_stock_symbol_response)
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'returns the detail of the user created' do
        params = { email: 'abuzzany@gmail.com' }

        post 'api/v1/users', params.to_json

        response = JSON.parse(last_response.body)

        expect(response['id']).not_to be_nil
        expect(response['message']).to be_eql('abuzzany@gmail.com')
      end
    end

    context 'with invalid params' do
      it 'returns an error message' do
        params = { email: nil }
        
        post 'api/v1/users', params.to_json

        response = JSON.parse(last_response.body)

        expect(response['id']).not_to be_nil
        expect(response['email']).to be_eql('abuzzany@gmail.com')
      end
    end
  end

  describe '#users#wallet' do
    context 'for an existing user' do
      it 'returns the detail of the stock bought' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)
        create_stock_price_logs

        aapl_lowest_price = StockPriceLog.where(
          stock_symbol: :AAPL,
          created_at: Date.current.beginning_of_day..Date.current.end_of_day
        ).minimum(:price)

        aapl_highest_price = StockPriceLog.where(
          stock_symbol: :AAPL,
          created_at: Date.current.beginning_of_day..Date.current.end_of_day
        ).maximum(:price)

        tsla_lowest_price = StockPriceLog.where(
          stock_symbol: :TSLA,
          created_at: Date.current.beginning_of_day..Date.current.end_of_day
        ).minimum(:price)

        tsla_highest_price = StockPriceLog.where(
          stock_symbol: :TSLA,
          created_at: Date.current.beginning_of_day..Date.current.end_of_day
        ).maximum(:price)

        get "api/v1/users/#{user.id}/wallet"

        response = JSON.parse(last_response.body)

        expect(last_response).to be_ok
        expect(response['user_id']).to be_eql(user.id.to_s)
        expect(response['stocks'].count).to be_eql(2)
        expect(response['stocks'].count).to be_eql(2)
        expect(response['stocks'][0]['stock_symbol']).to be_eql('AAPL')
        expect(response['stocks'][0]['profit_loss']).to be_eql(-28.0)
        expect(response['stocks'][0]['held_shares']).to be_eql(10)
        expect(response['stocks'][0]['current_stock_value']).to be_eql(1500.0)
        expect(response['stocks'][0]['lowest_price']).to be_eql(aapl_lowest_price)
        expect(response['stocks'][0]['highest_price']).to be_eql(aapl_highest_price)
        expect(response['stocks'][1]['stock_symbol']).to be_eql('TSLA')
        expect(response['stocks'][1]['profit_loss']).to be_eql(40.0)
        expect(response['stocks'][1]['held_shares']).to be_eql(5)
        expect(response['stocks'][1]['current_stock_value']).to be_eql(750.0)
        expect(response['stocks'][1]['lowest_price']).to be_eql(tsla_lowest_price)
        expect(response['stocks'][1]['highest_price']).to be_eql(tsla_highest_price)
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
        expect(response['total_amount']).to be_eql(1500.0)
      end
    end

    describe '#users#stocks#sell' do
      context 'for a valid stock symbol' do
        it 'returns the detail of the stock share sold' do
          user = User.create(email: 'abuzzany@gmail.com')

          params = {
            stock_symbol: 'AAPL',
            share_quantity: 10
          }

          post "api/v1/users/#{user.id}/stocks/sell", params.to_json

          response = JSON.parse(last_response.body)

          expect(last_response).to be_ok
          expect(response['user_id']).to be_eql(user.id)
          expect(response['transaction_type']).to be_eql('sell')
          expect(response['stock_symbol']).to be_eql('AAPL')
          expect(response['share_quantity']).to be_eql(10)
          expect(response['total_amount']).to be_eql(1500.0)
        end
      end
    end
  end
end
