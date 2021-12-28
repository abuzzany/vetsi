# frozen_string_literal: true

class ApplicationController < Sinatra::Base
  before do
    content_type 'application/json'
  end

  def request_params
    @request_params ||= JSON.parse(request.body.read)
  end

  def response_not_found(message = nil)
    halt 400, { message: message }.to_json
  end

  def response_error(message = nil)
    halt 500, { message: message }.to_json
  end
end
