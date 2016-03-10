require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class OrderItemsController < ApplicationController
    before_action :create_order, only: :create
    before_action :load_product, only: :create
    before_action :current_order

    def index
      @order_items = @order.order_items
      @order_items_price = @order.items_price
      @discount = Discount.new
    end

    def create
      @order.add_product(@product, params[:order_item][:quantity].to_i)
      redirect_to order_items_path
    end

    def update
      order_item = OrderItem.find(params[:id])
      order_item.calc_price(params[:order_item][:quantity].to_i)
      order_item.update(order_item_params)
      redirect_to order_items_path
    end

    def destroy
      order_item = OrderItem.find(params[:id])
      order_item.destroy
      redirect_to order_items_path
    end

    private

    def order_item_params
      params.require(:order_item).permit(:quantity, :price)
    end

    def load_product
      klass = ShoppingCart::PRODUCTS.map(&:constantize)
              .detect { |e| params["#{e.name.underscore}_id"] }
      @product = klass.find(params["#{klass.name.underscore}_id"])
    end

    def create_order
      unless cookies[:order_id]
        if current_user
          order = Order.create(customer: current_user)
          cookies[:order_id] = order.id
        else
          cookies[:order_id] = Order.create.id
        end
      end
    end

  end
end
