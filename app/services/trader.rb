# frozen_string_literal: true

# This service works to buy o sell shares for a given user
# and stock symbol.
class Trader
  attr_accessor :user_id,
                :stock_symbol,
                :share_quantity,
                :transaction_type

  def self.call(user_id, stock_symbol, share_quantity, transaction_type)
    new(user_id, stock_symbol, share_quantity, transaction_type).call
  end

  def initialize(user_id, stock_symbol, share_quantity, transaction_type)
    @user_id = user_id
    @stock_symbol = stock_symbol
    @share_quantity = share_quantity
    @transaction_type = transaction_type
  end

  def call
    result = run_checks

    return result unless result.success?

    commit_transaction
  end

  private

  def commit_transaction
    last_sale_price = NasdaqClient::Quotes.new(stock_symbol).last_sale_price

    transaction = Transaction.create(user_id: user_id,
                                     transaction_type: transaction_type,
                                     stock_symbol: stock_symbol,
                                     share_quantity: share_quantity,
                                     share_price: last_sale_price,
                                     total_amount: share_quantity * last_sale_price)

    OpenStruct.new(success?: true, payload: transaction) if transaction.persisted?
  end

  def valid_stock_symbol?
    Stocks::Validator.call(stock_symbol)
  end

  def run_checks
    return OpenStruct.new(success?: false, message: "user_id can't be nil") unless user_id
    return OpenStruct.new(success?: false, message: "User doesn't exist") unless User.exists?(user_id)
    return OpenStruct.new(success?: false, message: "stock_symbol can't be nil") unless stock_symbol
    return OpenStruct.new(success?: false, message: "share_quantity can't be nil") unless share_quantity
    return OpenStruct.new(success?: false, message: "transaction_type can't be nil") unless transaction_type

    unless valid_stock_symbol?
      return OpenStruct.new(success?: false, message: "stock_symbol '#{stock_symbol}' not found",
                            code: 400)
    end

    OpenStruct.new(success?: true)
  end
end
