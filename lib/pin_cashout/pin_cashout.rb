module PinCashout
  def self.cashout!
    raise "#{self.name}: Invalid configuration. Did you provide an api key?" unless config.valid?

    available_balance = Balance.new.available_balance

    if available_balance > 0
      transfer = Transfer.new(amount: available_balance)
      transfer.process!
    end
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
