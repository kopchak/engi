require 'rails/generators/base'

module ShoppingCart
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_views
      directory 'checkouts', 'app/views/shopping_cart/checkouts'
      directory 'order_items', 'app/views/shopping_cart/order_items'
      directory 'orders', 'app/views/shopping_cart/orders'
    end

    def copy_locale
      copy_file "../../../../../config/locales/en.yml", "config/locales/shopping_cart.en.yml"
    end
  end
end
