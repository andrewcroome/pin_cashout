module PinCashout
  class Transfer
    attr_accessor :amount, :currency, :description, :recipient

    def initialize(options={})
      @amount      = options.fetch(:amount)
      @currency    = options.fetch(:currency, 'AUD')
      @recipient   = options.fetch(:recipient, 'self')
      @description = options.fetch(:description, 'Cashout via PinCashout')
    end

    def process!
      check_valid_config

      @response = PinConnection.post(request_path, request_params)
      check_response_status

      processed? ? true : false
    end

    def processed?
      @response && @response.status == 201 ? true : false
    end

    def response_status
      @response.status if @response
    end

    def response_token
      @response.body['response']['token'] if @response
    end

    def response_amount
      @response.body['response']['amount'] if @response
    end

    def response
      @response
    end

    private

    def check_response_status
      case @response.status
      when 400
        # Pin's API document doesn't seem correct here so we don't raise the error with the message
        raise PinCashout::Error::InsufficientFunds
      when 402
        raise PinCashout::Error::InsufficientFunds, "#{@response.body['error_description']}"
      when 404
        raise PinCashout::Error::ResourceNotFound, "#{@response.body['error_description']}"
      when 422
        raise PinCashout::Error::InvalidResource, "#{@response.body['error_description']}"
      when 500
        raise PinCashout::Error::PinInternalServerError, "#{@response.body['error_description']}"
      end
    end

    def request_params
      {
        amount:      amount,
        currency:    currency,
        recipient:   recipient,
        description: description
      }
    end

    def request_path
      "/#{PinCashout.config.api_version}/transfers"
    end

    def check_valid_config
      raise "#{self.class}: Invalid configuration. Did you provide an api key?" unless PinCashout.config.valid?
    end
  end
end
