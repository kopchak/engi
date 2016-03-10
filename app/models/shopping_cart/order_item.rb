module ShoppingCart
  class OrderItem < ActiveRecord::Base
    belongs_to :product, polymorphic: true
    belongs_to :order

    validates :quantity, presence: true

    default_scope { order("id") }

    def calc_price(quantity)
      self.price = product.price * quantity
    end
  end
end
