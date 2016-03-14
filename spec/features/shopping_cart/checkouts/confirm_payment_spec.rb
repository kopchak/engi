require 'rails_helper'

describe "Confirm Payment", js: true do
  before do
    delivery = create(:shopping_cart_delivery)
    discount = create(:shopping_cart_discount)
    order = create(:shopping_cart_order, discount: discount, delivery: delivery)
    create_cookie(:order_id, order.id)
    visit(shopping_cart.checkouts_confirm_payment_path)
  end

  context 'content' do
    it 'i18n' do
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.confirm_payment.checkout_title'))
      expect(page).to have_link(I18n.t('shopping_cart.checkouts.confirm_payment.address_link'))
      expect(page).to have_link(I18n.t('shopping_cart.checkouts.confirm_payment.delivery_link'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.confirm_payment.credit_card_title'))
      expect(page).to have_link(I18n.t('shopping_cart.checkouts.confirm_payment.cvv_name_link'))
      expect(page).to have_button(I18n.t('shopping_cart.checkouts.confirm_payment.save'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.confirm_payment.summary_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.confirm_payment.items_price_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.confirm_payment.shipping_price_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.confirm_payment.discount_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.confirm_payment.order_total_info'))
    end
  end

  context 'can click' do
    it 'link address' do
      click_link(I18n.t('shopping_cart.checkouts.confirm_payment.address_link'))
      expect(page).to have_current_path(shopping_cart.checkouts_edit_address_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.checkout_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.billing_address_title'))
    end

    it 'link delivery' do
      click_link(I18n.t('shopping_cart.checkouts.confirm_payment.delivery_link'))
      expect(page).to have_current_path(shopping_cart.checkouts_choose_delivery_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.checkout_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.delivery_title'))
    end

    it "button 'save'" do
      fill_in('Card Number', with: Faker::Number.number(16))
      fill_in('Card Code', with: Faker::Number.number(3))
      click_button(I18n.t('shopping_cart.checkouts.confirm_payment.save'))
      expect(page).to have_current_path(shopping_cart.checkouts_overview_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.confirm_title'))
    end
  end
end
