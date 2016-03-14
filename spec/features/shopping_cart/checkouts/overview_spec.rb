require 'rails_helper'

describe "Overview", js: true do
  before do
    @order = create(:shopping_cart_order)
    book = create(:book)
    create_list(:shopping_cart_order_item, 3, product: book)
    @order.billing_address = create(:shopping_cart_address)
    @order.shipping_address = create(:shopping_cart_address)
    @order.delivery = create(:shopping_cart_delivery)
    @order.discount = create(:shopping_cart_discount)
    @order.credit_card = create(:shopping_cart_credit_card)
    @order.save
    create_cookie(:order_id, @order.id)
    visit(shopping_cart.checkouts_overview_path)
  end

  context 'content' do
    it 'i18n' do
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.checkout_title'))
      expect(page).to have_link(I18n.t('shopping_cart.checkouts.overview.address_link'))
      expect(page).to have_link(I18n.t('shopping_cart.checkouts.overview.delivery_link'))
      expect(page).to have_link(I18n.t('shopping_cart.checkouts.overview.credit_card_link'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.confirm_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.billing_address_title'))
      expect(page).to have_link(I18n.t('shopping_cart.checkouts.overview.edit_link'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.p_phone'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.shipping_address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.shipment_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.credit_card_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.product_name'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.product_price'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.qty'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.item_price'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.subtotal_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.shipping_price_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.discount_info'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.overview.order_total_info'))
      expect(page).to have_button(I18n.t('shopping_cart.checkouts.overview.place_order'))
    end
  end

  context 'can click' do
    it 'link address' do
      click_link(I18n.t('shopping_cart.checkouts.overview.address_link'))
      expect(page).to have_current_path(shopping_cart.checkouts_edit_address_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.billing_address_title'))
    end

    it 'link delivery' do
      click_link(I18n.t('shopping_cart.checkouts.overview.delivery_link'))
      expect(page).to have_current_path(shopping_cart.checkouts_choose_delivery_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.delivery_title'))
    end

    it 'link payment' do
      click_link(I18n.t('shopping_cart.checkouts.overview.credit_card_link'))
      expect(page).to have_current_path(shopping_cart.checkouts_confirm_payment_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.confirm_payment.credit_card_title'))
    end

    it 'link edit billing address block' do
      all(:xpath, "//a[@href='/shopping_cart/checkouts/edit_address']").first.click
      expect(page).to have_current_path(shopping_cart.checkouts_edit_address_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.billing_address_title'))
    end

    it 'link edit shipping address block' do
      all(:xpath, "//a[@href='/shopping_cart/checkouts/edit_address']").last.click
      expect(page).to have_current_path(shopping_cart.checkouts_edit_address_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.billing_address_title'))
    end

    it 'link edit shipments block' do
      find_link('(edit)', href: '/shopping_cart/checkouts/choose_delivery').click
      expect(page).to have_current_path(shopping_cart.checkouts_choose_delivery_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.choose_delivery.delivery_title'))
    end

    it 'link edit payment block' do
      find_link('(edit)', href: '/shopping_cart/checkouts/confirm_payment').click
      expect(page).to have_current_path(shopping_cart.checkouts_confirm_payment_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.confirm_payment.credit_card_title'))
    end
  end

  context 'click button' do
    before do
      user = create(:user)
      login_as(user)
      visit(shopping_cart.checkouts_overview_path)
    end

    it "place order" do
      click_button(I18n.t('shopping_cart.checkouts.overview.place_order'))
      expect(page).to have_current_path(shopping_cart.complete_order_path(@order.id))
      expect(page).to have_content(I18n.t('shopping_cart.orders.complete.order_title'))
    end
  end
end
