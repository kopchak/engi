module ShoppingCart
  class ApplicationController < ::ApplicationController
    def current_order
      begin
        @order ||= Order.find(cookies[:order_id])
      rescue
        @order = nil
      end
    end
  end
end
