# frozen_string_literal: true

class TradingController < ApplicationController
  post '/api/v1/trading' do
    response = Shares::Trader.call(request_params['user_id'],
                                   request_params['stock_symbol'],
                                   request_params['share_quantity'],
                                   request_params['transaction_type'])

    return halt 400, { message: response[:message] }.to_json if response[:code] == 400

    response[:payload].to_json if response[:success?]
  end
end
