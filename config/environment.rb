# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'

configure :development do
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'vetsi-development'
  )
end

configure :test do
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'vetsi-test'
  )
end

configure :production do
  # Database connection
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

  ActiveRecord::Base.establish_connection(
    adapter: db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host: db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..],
    encoding: 'utf8'
  )
end
