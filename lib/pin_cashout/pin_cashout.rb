module PinCashout
  def self.cashout!
    raise "#{self.name}: Invalid configuration. Did you provide an api key?" unless config.valid?

    transfer = Transfer.new
    transfer.process!
  end

  def self.configure
    @config ||= Config.new
    yield @config
  end

  def self.config=(data)
    @config = data
  end

  def self.config
    @config ||= Config.new
  end
end
