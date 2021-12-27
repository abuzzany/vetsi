# frozen_string_literal: true

require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/user'
require_relative 'models/transaction'
require_relative 'models/stock_price_log'
require_relative 'lib/services/investment_wallet'
require_relative 'lib/nasdaq_client/api'
require_relative 'lib/nasdaq_client/quotes'
require_relative 'lib/nasdaq_client/quote_exception'
require_relative 'lib/services/shares/trader'
require_relative 'lib/services/stocks/calculate_value'
require_relative 'lib/services/stocks/validator'

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  get '/users/:id/wallet' do |id|
    result = InvestmentWallet.for(id).call

    return halt 400, { message: result[:message] }.to_json if result[:code] == 400

    result.payload.to_json if result.success?
  end

  post '/users/:id/stocks/buy' do |id|
    response = Shares::Trader.call(id,
                                   request_params['stock_symbol'],
                                   request_params['share_quantity'],
                                   :buy)

    return halt 400, { message: response[:message] }.to_json if response[:code] == 400

    response[:payload].to_json if response[:success?]
  end

  post '/users/:id/stocks/sell' do |id|
    response = Shares::Trader.call(id,
                                   request_params['stock_symbol'],
                                   request_params['share_quantity'],
                                   :sell)

    return halt 400, { message: response[:message] }.to_json if response[:code] == 400

    response[:payload].to_json if response[:success?]
  end

  def request_params
    @request_params ||= JSON.parse(request.body.read)
  end
end
