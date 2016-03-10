module ShoppingCart
  class Engine < ::Rails::Engine
    isolate_namespace ShoppingCart

    config.to_prepare do
      ActiveRecord::Base.include ShoppingCart::ActsAsShoppingCart
    end
  end
end
