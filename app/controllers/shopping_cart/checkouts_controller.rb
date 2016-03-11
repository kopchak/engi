require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class CheckoutsController < ApplicationController
    before_action :current_order

    def edit_address
    end

    def update_address
      attrs_for_shipping = params[:use_billing_address] ? billing_params : shipping_params
      @order.billing_address.assign_attributes(billing_params)
      @order.shipping_address.assign_attributes(attrs_for_shiping)
      if @order.save
        redirect_to checkouts_choose_delivery_path
      else
        redirect_to checkouts_edit_address_path
      end
    end

    def choose_delivery
      @deliveries = Delivery.all
      @delivery = @order.delivery || @deliveries.first
    end

    def set_delivery
      @order.delivery_id = order_params[:delivery_id]
      @order.set_total_price
      redirect_to checkouts_confirm_payment_path
    end

    def confirm_payment
      @credit_card = @order.credit_card
    end

    def update_credit_card
      @order.credit_card.update(credit_card_params)
      redirect_to checkouts_overview_path
    end

    def overview
      @credit_card = @order.credit_card
      @billing_address = @order.billing_address
      @shipping_address = @order.shipping_address
    end

    def confirmation
      @order.confirm(current_user)
      cookies.delete(:order_id)
      redirect_to complete_order_path(@order.id)
    end

    private
    def billing_params
      params.require(:order).require(:billing_address_attributes).permit(:firstname, :lastname, :street_address, :city, :country, :zipcode, :phone)
    end

    def shipping_params
      params.require(:order).require(:shipping_address_attributes).permit(:firstname, :lastname, :street_address, :city, :country, :zipcode, :phone)
    end

    def order_params
      params.require(:order).permit(:delivery_id)
    end

    def credit_card_params
      params.require(:credit_card).permit(:number, :expiration_month, :expiration_year, :cvv)
    end
  end
end
