require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/user'
require_relative 'models/stock'
require_relative 'models/transaction'
require_relative 'lib/nasdaq_client/api'
require_relative 'lib/shares/buyer'
require_relative 'lib/stocks/holder_information'
require_relative 'lib/stocks/info'
require_relative 'lib/stock_validator'

# set :database, { adapter: 'sqlite3', database: 'foo.sqlite3' }

get '/' do
  'Hello world!'
end
