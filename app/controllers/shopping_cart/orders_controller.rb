require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class OrdersController < ApplicationController
    before_action :authenticate_user!, except: [:add_discount, :clear_cart]
    before_action :current_order, only: [:add_discount, :clear_cart]

    def index
      orders = current_user.orders
      @order_in_progress = current_order
      @orders_in_queue = orders.in_queue
      @orders_in_delivery = orders.in_delivery
      @orders_delivered = orders.delivered
    end

    def show
      @order = Order.find(params[:id])
    end

    def complete
      @order = Order.find(params[:id])
      @credit_card = @order.credit_card
      @billing_address = @order.billing_address
      @shipping_address = @order.shipping_address
    end

    def add_discount
      coupon = Discount.find_by(discount_params)
      @order.add_discount(coupon) if coupon
      redirect_to order_items_path
    end

    def clear_cart
      @order.order_items.destroy_all
      redirect_to order_items_path
    end

    private

    def discount_params
      params.require(:discount).permit(:code)
    end
  end
end
