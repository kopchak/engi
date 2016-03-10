require 'rails/generators/base'

module ShoppingCart
  class ControllersGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_controllers
      directory 'shopping_cart', 'app/controllers/shopping_cart'
    end
  end
end
