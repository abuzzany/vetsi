# frozen_string_literal: true

class UsersController < ApplicationController
  post '/api/v1/users' do
    user = User.create(email: request_params['email'])

    return user.to_json if user.persisted?

    halt 500, { message: user.errors.full_messages.join(',') }.to_json
  end
end
