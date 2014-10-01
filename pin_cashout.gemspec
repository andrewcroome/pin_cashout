# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pin_cashout/version'

Gem::Specification.new do |spec|
  spec.name          = "pin_cashout"
  spec.version       = PinCashout::VERSION
  spec.authors       = ["Andrew Croome"]
  spec.email         = ["andrewcroome@gmail.com"]
  spec.summary       = %q{Empty your Pin Payments account into your bank account.}
  spec.description   = %q{Transfer the balance of your Pin Payments account into your own bank account}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "vcr"

  spec.add_runtime_dependency "faraday", "~> 0.9"
  spec.add_runtime_dependency "faraday_middleware", "~> 0.9"
end
