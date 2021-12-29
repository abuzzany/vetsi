# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/activerecord'
require 'pry'

require './config/environment'

require './app/controllers/api/v1/application_controller'
require './app/controllers/api/v1/users_controller'
require './app/controllers/api/v1/trading_controller'
require './app/controllers/api/v1/wallets_controller'
require './app/models/user'
require './app/models/transaction'
require './app/models/stock_price_log'
require './app/services/investment_wallet'
require './app/services/nasdaq_client/api'
require './app/services/nasdaq_client/quotes'
require './app/services/nasdaq_client/quote_exception'
require './app/services/trader'
require './app/services/stocks/calculate_value'
require './app/services/stocks/validator'

# This class works as the entroypoint of Vetsi.
class Vetsi < Sinatra::Base
  use ApplicationController
  use UsersController
  use TradingController
  use WalletsController

  get '/' do
    'Hello from Vetsi!'
  end
end
