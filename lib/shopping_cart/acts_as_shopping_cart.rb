module ShoppingCart
  module ActsAsShoppingCart
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_customer
        CUSTOMERS.push(self.name).uniq!
        class_eval do
          has_many :orders, class_name: 'ShoppingCart::Order', dependent: :destroy, as: :customer
        end
      end

      def acts_as_product
        PRODUCTS.push(self.name).uniq!
        class_eval do
          has_many :order_items, class_name: 'ShoppingCart::OrderItem', as: :product
        end
      end
    end

  end
end
