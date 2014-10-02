module PinCashout
  class Error < StandardError
    class InvalidResource  < Error; end
    class ResourceNotFound < Error; end
    class InsufficientFunds < Error; end
  end
end
