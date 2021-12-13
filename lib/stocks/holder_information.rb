module Stocks
  # This class returnt the information of a bought share.
  class HolderInformation
    attr_reader :user

    def initialize(user_id)
      @user = User.find(user_id)
    end

    def stocks
      Transaction.where(user_id: user.id)
    end
  end
end
