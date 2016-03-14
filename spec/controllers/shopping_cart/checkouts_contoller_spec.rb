require 'rails_helper'

RSpec.describe ShoppingCart::CheckoutsController, :type => :controller do
  routes { ShoppingCart::Engine.routes }

  before do
    @order = create(:shopping_cart_order)
    cookies[:order_id] = @order.id
  end

  context 'GET#edit_address' do
    it 'render template edit_address' do
      get :edit_address
      expect(response).to render_template(:edit_address)
    end
  end

  context 'PATCH#update_address' do
    it 'with use billing address' do
      patch :update_address, use_billing_address: true, order: { 
                                                          billing_address_attributes: attributes_for(:shopping_cart_address)
                                                        }
      @order.reload
      expect(@order.billing_address.firstname).to eq(@order.shipping_address.firstname)
    end

    it 'without use billing address' do
      patch :update_address, order: { 
                              billing_address_attributes: attributes_for(:shopping_cart_address),
                              shipping_address_attributes: attributes_for(:shopping_cart_address)
                             }
      @order.reload
      expect(@order.billing_address.firstname).not_to eq(@order.shipping_address.firstname)
    end

    it 'redirect to checkouts_choose_delivery_path' do
      patch :update_address, use_billing_address: true, order: { 
                                                          billing_address_attributes: attributes_for(:shopping_cart_address)
                                                        }
      expect(response).to redirect_to(checkouts_choose_delivery_path)
    end
  end

  context 'GET#choose_delivery' do
    before do
      @delivery = create(:shopping_cart_delivery)
    end

    it 'render template choose_delivery' do
      get :choose_delivery
      expect(response).to render_template(:choose_delivery)
    end
  end

  context 'PATCH#set_delivery' do
    before do
      @delivery = create(:shopping_cart_delivery)
    end

    it 'redirect to checkouts_confirm_payment_path' do
      patch :set_delivery, order: { delivery_id: @delivery.id }
      expect(response).to redirect_to(checkouts_confirm_payment_path)
    end
  end

  context 'GET#confirm_payment' do
    it 'render template confirm_payment' do
      get :confirm_payment
      expect(response).to render_template(:confirm_payment)
    end
  end

  context 'PATCH#update_credit_card' do
    it 'redirect to checkouts_overview_path' do
      patch :update_credit_card, credit_card: attributes_for(:shopping_cart_credit_card)
      expect(response).to redirect_to(checkouts_overview_path)
    end
  end

  context 'GET#overview' do
    it 'render template overview' do
      get :overview
      expect(response).to render_template(:overview)
    end
  end

  context 'GET#confirmation' do
    before do
      user = create(:user)
      sign_in(user)
    end

    it 'redirect to complete_order_path' do
      get :confirmation
      expect(response).to redirect_to(complete_order_path(@order.id))
    end
  end

end