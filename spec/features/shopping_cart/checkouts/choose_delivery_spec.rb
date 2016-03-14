require 'rails_helper'

describe "Choose Delivery", js: true do
  before do
    create_list(:shopping_cart_delivery, 3)
    discount = create(:shopping_cart_discount)
    order = create(:shopping_cart_order, discount: discount)
    create_cookie(:order_id, order.id)
    visit(shopping_cart.checkouts_choose_delivery_path)
  end

  context 'content' do
    it 'i18n' do
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.checkout_title'))
      expect(page).to have_link(I18n.t('shopping_cart.checkouts.choose_delivery.address_link'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.delivery_title'))
      expect(page).to have_button(I18n.t('shopping_cart.checkouts.choose_delivery.save'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.summary_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.items_price_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.shipping_price_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.discount_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.order_total_info'))
    end
  end

  context 'can click' do
    it 'link address' do
      click_link(I18n.t('shopping_cart.checkouts.choose_delivery.address_link'))
      expect(page).to have_current_path(shopping_cart.checkouts_edit_address_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.checkout_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.billing_address_title'))
    end

    it 'any delivery' do
      all(:xpath, "//input[@type='radio']").last.click
      click_button(I18n.t('shopping_cart.checkouts.choose_delivery.save'))
      expect(page).to have_current_path(shopping_cart.checkouts_confirm_payment_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.confirm_payment.credit_card_title'))
    end
  end

end
