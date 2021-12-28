# frozen_string_literal: true

# This controller contains the logic to work with users.
class UsersController < ApplicationController
  post '/api/v1/users' do
    user = User.create(email: request_params['email'])

    return user.to_json if user.persisted?

    response_error(user.errors.full_messages.join(','))
  end
end
