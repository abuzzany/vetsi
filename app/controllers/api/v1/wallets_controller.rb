# frozen_string_literal: true

class WalletsController < ApplicationController
  get '/api/v1/users/:id/wallet' do |id|
    result = InvestmentWallet.for(id).call

    return response_not_found(response[:message]) if result[:code] == 400

    result.payload.to_json if result.success?
  end
end
