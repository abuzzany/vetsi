class Transaction < ActiveRecord::Base
    enum transaction_type: { sell: 0, buy: 1 }
end