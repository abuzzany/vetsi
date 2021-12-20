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

get '/user/:id/wallet' do |id|
  InvestmentWallet.for(id).call.to_json
end