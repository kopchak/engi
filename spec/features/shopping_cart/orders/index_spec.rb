require 'rails_helper'

describe "Index", js: true do
  before do
    user = create(:user)
    delivery = create(:shopping_cart_delivery)
    discount = create(:shopping_cart_discount)
    book = create(:book)
    @order = create(:shopping_cart_order, customer: user, delivery_id: delivery.id, discount: discount)
    create(:shopping_cart_order_item, order_id: @order.id, product: book)
    @order2 = create(:shopping_cart_order, customer: user, delivery_id: delivery.id, state: 'in_queue')
    create(:shopping_cart_order_item, order_id: @order2.id, product: book)
    create_list(:shopping_cart_order, 2, customer: user, state: 'in_delivery')
    create_list(:shopping_cart_order, 2, customer: user, state: 'delivered')
    login_as(user)
    create_cookie(:order_id, @order.id)
    visit(shopping_cart.orders_path)
  end

  context 'content' do
    it 'i18n' do
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.orders_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.in_progress_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.product_name'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.product_price'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.qty'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.item_price'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.subtotal_info'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.shipping_price_info'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.discount_info'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.in_queue_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.column_number'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.column_complete_date'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.column_total'))
      expect(page).to have_link(I18n.t('shopping_cart.orders.index.link_view'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.in_delivery_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.delivered_title'))
    end
  end

  context 'can click' do
    it 'link order#number' do
      click_link("#{I18n.t('shopping_cart.orders.index.order_title_link')}##{@order2.id}")
      expect(page).to have_current_path(shopping_cart.order_path(@order2.id))
      expect(page).to have_link(I18n.t('shopping_cart.orders.show.link_back_to_orders'))
    end

    it 'link view' do
      all('a', text: 'view').first.click
      expect(page).to have_current_path(shopping_cart.order_path(@order2.id))
      expect(page).to have_link(I18n.t('shopping_cart.orders.show.link_back_to_orders'))
    end
  end
end
