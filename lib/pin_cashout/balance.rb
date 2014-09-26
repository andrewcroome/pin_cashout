module PinCashout
  class Balance
    def available_balance
      pin_response_body['available'][0]['amount']
    end

    # private

    def pin_response_body
      PinConnection.client.get(fake_request_path_for_now).body
    end

    def request_path
      "/#{PinCashout.config.api_version}/balance"
    end

    def fake_request_path_for_now
      "/#{PinCashout.config.api_version}/charges"
    end
  end
end
