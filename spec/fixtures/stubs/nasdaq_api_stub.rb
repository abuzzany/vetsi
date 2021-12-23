# frozen_string_literal: true

module NasdaqApiStubs
  def valid_stock_symbol_response
    {
      'status': {
        'rCode': 200
      },
      'data': {
        'symbol': 'AAPL',
        'companyName': 'Apple Inc. Common Stock'
      }
    }.as_json
  end
end
