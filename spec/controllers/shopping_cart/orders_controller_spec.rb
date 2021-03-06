require 'rails_helper'

RSpec.describe ShoppingCart::OrdersController, :type => :controller do
  routes { ShoppingCart::Engine.routes }

  before do
    user = create(:user)
    @order = create(:shopping_cart_order, customer: user)
    sign_in(user)
  end

  context 'GET#index' do
    it 'render index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  context 'GET#show' do
    it 'render show template' do
      get :show, id: @order.id
      expect(response).to render_template(:show)
    end
  end

  context 'GET#complete' do
    it 'render complete template' do
      get :complete, id: @order.id
      expect(response).to render_template(:complete)
    end
  end

  context 'PATCH#add_discount' do
    before do
      cookies[:order_id] = @order.id
    end

    it 'redirect to order_items_path' do
      patch :add_discount, id: @order.id, discount: { code: Faker::Number.number(6) }
      expect(response).to redirect_to(order_items_path)
    end

    it 'get success message' do
      discount = create(:shopping_cart_discount)
      patch :add_discount, id: @order.id, discount: { code: discount.code }
      expect(flash.notice).to eq(I18n.t('shopping_cart.orders.add_discount_succ'))
    end

    it 'get err message' do
      patch :add_discount, id: @order.id, discount: { code: Faker::Number.number(6) }
      expect(flash.notice).to eq(I18n.t('shopping_cart.orders.add_discount_err'))
    end
  end

  context 'DELETE#clear_cart' do
    before do
      cookies[:order_id] = @order.id
    end

    it 'redirect to order_items_path' do
      delete :clear_cart, id: @order.id
      expect(response).to redirect_to(order_items_path)
    end

    it 'get clear_cart message' do
      delete :clear_cart, id: @order.id
      expect(flash.notice).to eq(I18n.t('shopping_cart.orders.clear_cart'))
    end
  end
end
