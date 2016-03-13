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
    it 'redirect to order_items_path' do
      patch :add_discount, id: @order.id, discount: { code: Faker::Number.number(6) }
      expect(response).to redirect_to(order_items_path)
    end
  end

  context 'DELETE#clear_cart' do
    it 'redirect to order_items_path' do
      cookies[:order_id] = @order.id
      delete :clear_cart, id: @order.id
      expect(response).to redirect_to(order_items_path)
    end
  end
end