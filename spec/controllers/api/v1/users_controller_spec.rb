# frozen_string_literal: true

require 'rack/test'
require './spec/fixtures/transactions/transactions_mock'
require './spec/fixtures/stock_price_logs/stock_price_logs_mock'
require './spec/fixtures/stubs/nasdaq_api_stub'

RSpec.describe 'Api/v1/users' do
  include Rack::Test::Methods

  def app
    Vetsi
  end

  describe 'POST' do
    context 'with valid params' do
      it 'returns the detail of the user created' do
        params = { email: 'abuzzany@gmail.com' }

        post 'api/v1/users', params.to_json

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)

        expect(response['id']).not_to be_nil
        expect(response['email']).to be_eql('abuzzany@gmail.com')
      end
    end

    context 'with invalid params' do
      it 'returns an error message' do
        params = { email: nil }

        post 'api/v1/users', params.to_json

        expect(last_response).to_not be_ok

        response = JSON.parse(last_response.body)

        expect(response['message']).to be_eql("Email can't be blank")
      end
    end
  end
end
