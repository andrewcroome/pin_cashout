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

      response = PinConnection.post(request_path, request_params)
      @response_status = response.status
      @response = response
    end

    def response_status
      @response_status
    end

    def response_amount
      @response.body['response']['amount'] if @response
    end

    private

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
  end
end
