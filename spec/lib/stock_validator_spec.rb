ENV['APP_ENV'] = 'test'

require './lib/stock_validator'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

RSpec.describe StockValidator do
  include Rack::Test::Methods

  it 'validates that a symbol is correct' do
    described_class.call
  end
end
