# PinCashout

Empty your Pin Payments account into your bank account.

## Installation

Add this line to your application's Gemfile:

    gem 'pin_cashout'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pin_cashout

## Usage

Please note that this gem is still in development. It also depends on an API that is not yet available.

    PinCashout.configure do |config|
      config.pin_environment = :test # or :live
      config.secret_api_key = "your-secret-api-key"
    end


    available_balance = PinCashout::Balance.new.available_balance

    transfer = PinCashout::Transfer.new(amount: available_balance)

    transfer.process!
