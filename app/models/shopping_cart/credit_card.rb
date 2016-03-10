module ShoppingCart
  class CreditCard < ActiveRecord::Base
    has_one   :order

    validates :number, :expiration_month, :expiration_year, :cvv, presence: true, on: :update
  end
end
