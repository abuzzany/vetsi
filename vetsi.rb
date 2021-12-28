# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/activerecord'
require 'pry'

require './controllers/api/v1/application_controller'
require './controllers/api/v1/users_controller'

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

class Vetsi < Sinatra::Base
  use ApplicationController
  use UsersController

  get '/' do
    'Hello from Vetsi!'
  end

  # run!
end
