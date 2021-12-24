# frozen_string_literal: true

# This class works as a custom error for NasdaqClient::Quote class.
module NasdaqClient
  class QuoteException < StandardError
  end
end
