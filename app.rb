require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/user'
require_relative 'lib/nasdaq_client/api'
require_relative 'lib/shares/buyer'
require_relative 'lib/stock_validator'

set :database, { adapter: 'sqlite3', database: 'foo.sqlite3' }

get '/' do
  'Hello world!'
end
