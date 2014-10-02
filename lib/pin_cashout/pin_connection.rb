module PinCashout
  class PinConnection
    def self.get(request_path)
      client.get(request_path)
    end

    def self.post(request_path, request_params={})
      client.post(request_path, request_params)
    end

    private

    def self.client
      @pin_client ||= Faraday.new(url: request_url) do |faraday|
        faraday.request    :url_encoded
        faraday.response   :json, :content_type => /\bjson$/
        faraday.adapter    Faraday.default_adapter
        faraday.basic_auth PinCashout.config.secret_api_key, ''
      end
    end

    def self.request_url
      "#{PinCashout.config.protocol}://#{PinCashout.config.api_host}"
    end
  end
end
