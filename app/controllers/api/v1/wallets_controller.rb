# frozen_string_literal: true

class WalletsController < ApplicationController
  get '/api/v1/users/:id/wallet' do |id|
    result = InvestmentWallet.for(id).call

    return halt 400, { message: result[:message] }.to_json if result[:code] == 400

    result.payload.to_json if result.success?
  end
end
