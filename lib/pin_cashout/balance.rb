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
      check_valid_config

      @response = PinConnection.get(request_path)
      check_response_status

      @response.body
    end

    def check_response_status
      case @response.status
      when 404
        raise PinCashout::Error::ResourceNotFound, "#{@response.body['error_description']}"
      when 422
        raise PinCashout::Error::InvalidResource, "#{@response.body['error_description']}"
      end
    end

    def request_path
      "/#{PinCashout.config.api_version}/balance"
    end

    def check_valid_config
      raise "#{self.class}: Invalid configuration. Did you provide an api key?" unless PinCashout.config.valid?
    end
  end
end
