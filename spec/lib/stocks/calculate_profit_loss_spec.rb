# frozen_string_literal: true

require './spec/fixtures/transactions/transactions_mock'

RSpec.describe Stocks::CalculateProfitLoss do
  include TransactionsMock

  describe '.run' do
    context 'for a valid stock symbol' do
      it 'should calculates the profit or loss amount' do
        user = User.create(email: 'abuzzany@gmail.com')

        create_transactions(user.id)

        result = described_class.run(user.id, :AAPL)

        expect(result).to be_eql(1711.3999999999999)
      end
    end
  end
end
