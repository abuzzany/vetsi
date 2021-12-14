# frozen_string_literal: true

# This models represents the current share stock of a user.
class Stock < ActiveRecord::Base
  validates_presence_of :user_id,
                        :stock_symbol,
                        :total_shares
end
