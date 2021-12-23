# frozen_string_literal: true

require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/user'
require_relative 'models/transaction'
require_relative 'lib/services/investment_wallet'
require_relative 'lib/nasdaq_client/api'
require_relative 'lib/services/shares/trader'
require_relative 'lib/services/shares/calculate_held_quantity'
require_relative 'lib/services/stocks/calculate_profit_loss'
require_relative 'lib/services/stocks/info'
require_relative 'lib/services/stocks/validator'

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  get '/users/:id/wallet' do |id|
    InvestmentWallet.for(id).call.to_json
  end

  post '/users/:id/stocks/buy' do |id|
    response = Shares::Trader.call(id,
                                  request_params['stock_symbol'],
                                  request_params['share_quantity'],
                                  :buy)

    return halt 400, { message: response[:message] }.to_json if response[:code] == 400

    response[:payload].to_json if response[:success?]
  end

  def request_params
    @request_params ||= JSON.parse(request.body.read)
  end
end
