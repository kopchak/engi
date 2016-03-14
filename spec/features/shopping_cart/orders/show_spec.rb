require 'rails_helper'

describe "Show", js: true do
  before do
    user = create(:user)
    book = create(:book)
    delivery = create(:shopping_cart_delivery)
    discount = create(:shopping_cart_discount)
    order = create(:shopping_cart_order, state: 'in_queue', customer: user, delivery: delivery, discount: discount)
    create(:shopping_cart_order_item, order: order, product: book)
    login_as(user)
    visit(shopping_cart.order_path(order.id))
  end

  context 'content' do
    it 'i18n' do
      expect(page).to have_content(I18n.t('shopping_cart.orders.show.order_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.show.link_back_to_orders'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.show.product_name'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.show.product_price'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.show.qty'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.show.item_price'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.show.subtotal_info'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.show.shipping_price_info'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.show.discount_info'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.show.order_total_info'))
    end
  end

  context 'can click' do
    it 'link back to orders' do
      click_link("<< #{I18n.t('shopping_cart.orders.show.link_back_to_orders')}")
      expect(page).to have_current_path(shopping_cart.orders_path)
      expect(page).to have_content(I18n.t('shopping_cart.orders.index.orders_title'))
    end
  end
end
