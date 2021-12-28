# frozen_string_literal: true

# This contoller works to return the user stock wallet.
class WalletsController < ApplicationController
  get '/api/v1/users/:id/wallet' do |id|
    result = InvestmentWallet.for(id).call

    return response_not_found(result[:message]) if result[:code] == 400

    result.payload.to_json if result.success?
  end
end
