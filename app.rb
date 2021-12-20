# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/user'
require_relative 'models/stock'
require_relative 'models/transaction'
require_relative 'lib/nasdaq_client/api'
require_relative 'lib/shares/buyer'
require_relative 'lib/shares/calculate_held_quantity'
require_relative 'lib/stocks/calculate_profit_loss'
require_relative 'lib/stocks/holder_information'
require_relative 'lib/stocks/info'
require_relative 'lib/stock_validator'

get '/' do
  'Hello world!'
end
