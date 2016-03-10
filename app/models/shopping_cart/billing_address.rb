module ShoppingCart
  class BillingAddress < Address
    has_one :order
  end
end
