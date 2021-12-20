# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/user'
require_relative 'models/transaction'
require_relative 'lib/investment_wallet'
require_relative 'lib/nasdaq_client/api'
require_relative 'lib/shares/buyer'
require_relative 'lib/shares/calculate_held_quantity'
require_relative 'lib/stocks/calculate_profit_loss'
require_relative 'lib/stocks/info'
require_relative 'lib/stocks/validator'

get '/' do
  'Hello world!'
end

get '/users/:id/wallet' do |id|
  InvestmentWallet.for(id).call.to_json
end

post '/users/:id/stocks/buy' do |id|
  request_params = JSON.parse(request.body.read)

  response = Shares::Buyer.call(id,
                                request_params['stock_symbol'],
                                request_params['share_quantity'],
                                :buy)

  response[:transaction].to_json
end
