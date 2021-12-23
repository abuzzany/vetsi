# frozen_string_literal: true

module NasdaqApiStubs
  def valid_stock_symbol_response
    {
      'status': {
        'rCode': 200
      },
      'data': {
        'symbol': 'AAPL',
        'companyName': 'Apple Inc. Common Stock',
        'primaryData': {
          'lastSalePrice': '$150.00'
        }
      }
    }.as_json
  end

  def invalid_stock_symbol_response
    {
      'status': {
        'rCode': 400
      }
    }.as_json
  end
end
