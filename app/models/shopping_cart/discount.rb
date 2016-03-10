module ShoppingCart
  class Discount < ActiveRecord::Base
    before_create :create_code
    has_one   :order
    validates :amount, presence: true

    private
    def create_code
      self.code = rand(100000..999999)
    end
  end
end
