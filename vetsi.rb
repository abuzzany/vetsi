# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/activerecord'
require 'pry'

require './controllers/api/v1/application_controller'
require './controllers/api/v1/users_controller'
require './controllers/api/v1/trading_controller'
require './controllers/api/v1/wallets_controller'

require_relative 'models/user'
require_relative 'models/transaction'
require_relative 'models/stock_price_log'
require_relative 'app/services/investment_wallet'
require_relative 'app/nasdaq_client/api'
require_relative 'app/nasdaq_client/quotes'
require_relative 'app/nasdaq_client/quote_exception'
require_relative 'app/services/shares/trader'
require_relative 'app/services/stocks/calculate_value'
require_relative 'app/services/stocks/validator'

class Vetsi < Sinatra::Base
  use ApplicationController
  use UsersController
  use TradingController
  use WalletsController

  get '/' do
    'Hello from Vetsi!'
  end

  # run!
end
