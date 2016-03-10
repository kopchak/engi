module ShoppingCart
  class ShippingAddress < Address
    has_one :order
  end
end
