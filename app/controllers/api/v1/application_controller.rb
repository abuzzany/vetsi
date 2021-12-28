# frozen_string_literal: true

class ApplicationController < Sinatra::Base
  before do
    content_type 'application/json'
  end

  def request_params
    @request_params ||= JSON.parse(request.body.read)
  end
end
