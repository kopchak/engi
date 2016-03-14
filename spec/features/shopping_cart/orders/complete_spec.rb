require 'rails_helper'

describe "Complete", js: true do
  before do
    user = create(:user)
    @order = create(:shopping_cart_order, customer: user)
    book = create(:book)
    create_list(:shopping_cart_order_item, 3, order: @order, product: book)
    @order.billing_address = create(:shopping_cart_address)
    @order.shipping_address = create(:shopping_cart_address)
    @order.delivery = create(:shopping_cart_delivery)
    @order.discount = create(:shopping_cart_discount)
    @order.credit_card = create(:shopping_cart_credit_card)
    @order.save
    login_as(user)
    visit(shopping_cart.complete_order_path(@order.id))
  end

  context 'content' do
    it 'i18n' do
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.order_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.confirm_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.billing_address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.address_phone'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.shipping_address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.shipment_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.credit_card_title'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.product_name'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.product_price'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.qty'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.item_price'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.subtotal_info'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.shipping_price_info'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.discount_info'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.order_total_info'))
      expect(page).to have_button(I18n.t('shopping_cart.orders.complete.back_to_store'))
    end
  end

  context 'can click' do
    it 'button go back store' do
      click_button(I18n.t('shopping_cart.orders.complete.back_to_store'))
      expect(page).to have_current_path(root_path)
    end
  end

end
