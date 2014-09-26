module PinCashout
  class Config
    attr_accessor :pin_environment
    attr_accessor :api_version
    attr_accessor :live_api_host
    attr_accessor :test_api_host
    attr_accessor :protocol
    attr_accessor :secret_api_key

    def initialize
      set_defaults
    end

    def set_defaults
      @pin_environment = :test
      @api_version     = '1'
      @test_api_host   = 'test-api.pin.net.au'
      @live_api_host   = 'api.pin.net.au'
      @protocol        = 'https'
    end

    def valid?
      required_settings.all?
    end

    def api_host
      @api_host ||= begin
        if pin_environment == :live
          live_api_host
        elsif pin_environment == :test
          test_api_host
        else
          raise "#{self.name} API host for #{pin_environment} unknown"
        end
      end
    end

    private

    def required_settings
      [
        pin_environment,
        api_version,
        live_api_host,
        test_api_host,
        secret_api_key
      ]
    end
  end
end
