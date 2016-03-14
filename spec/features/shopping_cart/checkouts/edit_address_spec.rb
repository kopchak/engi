require 'rails_helper'

describe "Edit Address", js: true do
  before do
    discount = create(:shopping_cart_discount)
    order = create(:shopping_cart_order, discount: discount)
    create_cookie(:order_id, order.id)
    visit(shopping_cart.checkouts_edit_address_path)
  end

  context 'content' do
    it 'i18n' do
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.checkout_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.billing_address_title'))
      expect(page).to have_button(I18n.t('shopping_cart.checkouts.edit_address.save'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.shipping_address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.summary_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.items_price_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.discount_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.order_total_info'))
    end
  end

  context 'can click' do
    before do
      create_list(:shopping_cart_delivery, 3)
    end

    it "button 'save'" do
      fill_in('order_billing_address_attributes_firstname', with: Faker::Name.first_name)
      fill_in('order_billing_address_attributes_lastname',  with: Faker::Name.last_name)
      fill_in('order_billing_address_attributes_street_address', with: Faker::Address.street_address)
      fill_in('order_billing_address_attributes_city', with: Faker::Address.city)
      find('#order_billing_address_attributes_country').select('Ukraine')
      fill_in('order_billing_address_attributes_zipcode', with: Faker::Number.number(5))
      fill_in('order_billing_address_attributes_phone', with: Faker::Number.number(10))
      click_button(I18n.t('shopping_cart.checkouts.edit_address.save'))
      expect(page).to have_current_path(shopping_cart.checkouts_choose_delivery_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.checkout_title'))
      expect(page).to have_link(I18n.t('shopping_cart.checkouts.choose_delivery.address_link'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.delivery_title'))
    end
  end
end
