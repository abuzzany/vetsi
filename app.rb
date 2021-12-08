require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/user'

set :database, {adapter: "sqlite3", database: "foo.sqlite3"}

get '/' do
  'Hello world!'
end
