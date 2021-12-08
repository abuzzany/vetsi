require 'sinatra'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "foo.sqlite3"}

get '/' do
  'Hello world!'
end
