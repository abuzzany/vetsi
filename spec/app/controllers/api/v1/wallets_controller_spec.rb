# frozen_string_literal: true

require 'rack/test'
require './spec/fixtures/transactions/transactions_mock'
require './spec/fixtures/stock_price_logs/stock_price_logs_mock'
require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe 'Api/v1/users/wallets' do
  include Rack::Test::Methods
  include TransactionsMock
  include StockPriceLogsMock
  include NasdaqApiStubs

  def app
    Vetsi
  end

  let(:aapl_lowest_price) do
    StockPriceLog.where(
      stock_symbol: :AAPL,
      created_at: Date.current.beginning_of_day..Date.current.end_of_day
    ).minimum(:price).to_f
  end

  let(:aapl_highest_price) do
    StockPriceLog.where(
      stock_symbol: :AAPL,
      created_at: Date.current.beginning_of_day..Date.current.end_of_day
    ).maximum(:price).to_f
  end

  let(:aapl_average_price) do
    StockPriceLog.where(
      stock_symbol: :AAPL,
      created_at: Date.current.beginning_of_day..Date.current.end_of_day
    ).average(:price).to_f
  end

  let(:tsla_lowest_price) do
    StockPriceLog.where(
      stock_symbol: :TSLA,
      created_at: Date.current.beginning_of_day..Date.current.end_of_day
    ).minimum(:price).to_f
  end

  let(:tsla_highest_price) do
    StockPriceLog.where(
      stock_symbol: :TSLA,
      created_at: Date.current.beginning_of_day..Date.current.end_of_day
    ).maximum(:price).to_f
  end

  let(:tsla_average_price) do
    StockPriceLog.where(
      stock_symbol: :TSLA,
      created_at: Date.current.beginning_of_day..Date.current.end_of_day
    ).average(:price).to_f
  end

  before(:each) do
    allow(HTTParty).to receive(:get).and_return(valid_stock_symbol_response)
  end

  describe 'GET' do
    context 'for an existing user' do
      it 'returns its wallet' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)
        create_stock_price_logs

        get "api/v1/users/#{user.id}/wallet"

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)

        expect(response['user_id']).to be_eql(user.id.to_s)
        expect(response['stocks'].count).to be_eql(2)
        expect(response['stocks'].count).to be_eql(2)
        expect(response['stocks'][0]['stock_symbol']).to be_eql('AAPL')
        expect(response['stocks'][0]['profit_loss']).to be_eql(-28.0)
        expect(response['stocks'][0]['held_shares']).to be_eql(10.0)
        expect(response['stocks'][0]['current_stock_value']).to be_eql(1500.0)
        expect(response['stocks'][0]['current_day_references_price']['lowest_price']).to be_eql(aapl_lowest_price)
        expect(response['stocks'][0]['current_day_references_price']['highest_price']).to be_eql(aapl_highest_price)
        expect(response['stocks'][0]['current_day_references_price']['average_price']).to be_eql(aapl_average_price)
        expect(response['stocks'][1]['stock_symbol']).to be_eql('TSLA')
        expect(response['stocks'][1]['profit_loss']).to be_eql(40.0)
        expect(response['stocks'][1]['held_shares']).to be_eql(5.0)
        expect(response['stocks'][1]['current_stock_value']).to be_eql(750.0)
        expect(response['stocks'][1]['current_day_references_price']['lowest_price']).to be_eql(tsla_lowest_price)
        expect(response['stocks'][1]['current_day_references_price']['highest_price']).to be_eql(tsla_highest_price)
        expect(response['stocks'][1]['current_day_references_price']['average_price']).to be_eql(tsla_average_price)
      end
    end
  end
end
