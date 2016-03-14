require 'rails_helper'

RSpec.describe ShoppingCart::OrderItemsController, :type => :controller do
  routes { ShoppingCart::Engine.routes }
  before do
    order = create(:shopping_cart_order)
    cookies[:order_id] = order.id
  end

  context 'GET#index' do
    it 'render index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  context 'POST#create' do
    before do
      @book = create(:book)
    end

    it 'redirect to order_items_path' do
      post :create, order_item: { quantity: 1 }, book_id: @book.id
      expect(response).to redirect_to(order_items_path)
    end

    it 'get added message' do
      post :create, order_item: { quantity: 1 }, book_id: @book.id
      expect(flash.notice).to eq(I18n.t('shopping_cart.order_items.product.add'))
    end
  end

  context 'PATCH#update' do
    before do
      @book = create(:book)
      @order_item = create(:shopping_cart_order_item, product: @book)
    end

    it 'redirect to order_items_path' do
      patch :update, id: @order_item.id, order_item: { quantity: 2 }
      expect(response).to redirect_to(order_items_path)
    end

    it 'get updated message' do
      patch :update, id: @order_item.id, order_item: { quantity: 2 }
      expect(flash.notice).to eq(I18n.t('shopping_cart.order_items.product.update'))
    end
  end

  context 'DELETE#destroy' do
    before do
      book = create(:book)
      @order_item = create(:shopping_cart_order_item, product: book)
    end

    it 'redirect to order_items_path' do
      delete :destroy, id: @order_item.id
      expect(response).to redirect_to(order_items_path)
    end

    it 'get delete message' do
      delete :destroy, id: @order_item.id
      expect(flash.notice).to eq(I18n.t('shopping_cart.order_items.product.delete'))
    end
  end

end
