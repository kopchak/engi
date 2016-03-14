require 'rails_helper'

describe "Index", js: true do
  context 'content' do
    context 'without products' do
      before do
        visit(shopping_cart.order_items_path)
      end

      it 'i18n' do
        expect(page).to have_content(I18n.t('shopping_cart.order_items.index.cart_title'))
        expect(page).to have_content(I18n.t('shopping_cart.order_items.index.empty_cart'))
      end
    end

    context 'with products' do
      before do
        order = create(:shopping_cart_order)
        create_list(:shopping_cart_order_item, 2, order: order, product: create(:book))
        create_cookie(:order_id, order.id)
        visit(shopping_cart.order_items_path)
      end

      it 'i18n' do
        expect(page).to have_content(I18n.t('shopping_cart.order_items.index.cart_title'))
        expect(page).to have_content(I18n.t('shopping_cart.order_items.index.product_name'))
        expect(page).to have_content(I18n.t('shopping_cart.order_items.index.product_price'))
        expect(page).to have_content(I18n.t('shopping_cart.order_items.index.qty'))
        expect(page).to have_content(I18n.t('shopping_cart.order_items.index.item_price'))
        expect(page).to have_button(I18n.t('shopping_cart.order_items.index.ok'))
        expect(page).to have_link(I18n.t('shopping_cart.order_items.index.delete_item'))
        expect(page).to have_content(I18n.t('shopping_cart.order_items.index.order_total'))
        expect(page).to have_link(I18n.t('shopping_cart.order_items.index.clear_cart'))
        expect(page).to have_button(I18n.t('shopping_cart.order_items.index.update'))
        expect(page).to have_link(I18n.t('shopping_cart.order_items.index.checkout'))
      end
    end

    context 'with discount' do
      before do
        discount = create(:shopping_cart_discount)
        order = create(:shopping_cart_order, discount: discount)
        create_list(:shopping_cart_order_item, 2, order: order, product: create(:book))
        create_cookie(:order_id, order.id)
        visit(shopping_cart.order_items_path)
      end

      it 'i18n' do
        expect(page).to have_content(I18n.t('shopping_cart.order_items.index.discount'))
      end
    end
  end

  context 'can click' do
    before do
      order = create(:shopping_cart_order)
      create_list(:shopping_cart_order_item, 2, order: order, product: create(:book))
      create_cookie(:order_id, order.id)
      visit(shopping_cart.order_items_path)
    end

    it "button 'ok'" do
      elem = first('.edit_order_item')
      elem.fill_in('order_item_quantity', with: 5)
      elem.click_button('ok')
      expect(page).to have_content(I18n.t('shopping_cart.order_items.product.update'))
    end

    it 'X' do
      first('a', text: 'X').click
      expect(page).to have_content(I18n.t('shopping_cart.order_items.product.delete'))
    end

    it 'clear_cart' do
      click_link(I18n.t('shopping_cart.order_items.index.clear_cart'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.clear_cart'))
      expect(page).to have_content(I18n.t('shopping_cart.order_items.index.empty_cart'))
    end

    it 'update whith nonexistent discount' do
      click_button(I18n.t('shopping_cart.order_items.index.update'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.add_discount_err'))
    end

    it 'update whith existent discount' do
      discount = create(:shopping_cart_discount)
      find('.discount_code').fill_in('coupon code', with: discount.code)
      click_button(I18n.t('shopping_cart.order_items.index.update'))
      expect(page).to have_content(I18n.t('shopping_cart.orders.add_discount_succ'))
    end

    it 'checkout' do
      click_link('Checkout')
      expect(page).to have_current_path(shopping_cart.checkouts_edit_address_path)
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.checkout_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.address_title'))
      expect(page).to have_content(I18n.t('shopping_cart.checkouts.edit_address.billing_address_title'))
    end
  end
end
