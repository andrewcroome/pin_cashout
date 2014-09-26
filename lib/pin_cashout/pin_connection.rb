module PinCashout
  class PinConnection
    def self.client
      @pin_client ||= Faraday.new(url: request_url) do |faraday|
        faraday.response :json, :content_type => /\bjson$/
        faraday.adapter Faraday.default_adapter
        faraday.basic_auth PinCashout.config.secret_api_key, ''
      end
    end

    private

    def self.request_url
      "#{PinCashout.config.protocol}://#{PinCashout.config.api_host}"
    end
  end
end
