module PinCashout
  class Balance
    def available_balance
      pin_response_body['response']['available'][0]['amount']
    end

    def available_currency
      pin_response_body['response']['available'][0]['currency']
    end

    def pending_balance
      pin_response_body['response']['pending'][0]['amount']
    end

    def pending_currency
      pin_response_body['response']['pending'][0]['currency']
    end

    private

    def pin_response_body
      PinConnection.get(request_path).body
    end

    def request_path
      "/#{PinCashout.config.api_version}/balance"
    end
  end
end
