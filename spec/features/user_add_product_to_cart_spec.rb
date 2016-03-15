require 'rails_helper'

describe "User can add", js: true do
  context "to cart" do
    it "book" do
      create_list(:book, 3)
      visit(books_path)
      first('#new_order_item').click_button('Add to cart')
      expect(page).to have_current_path(shopping_cart.order_items_path)
      expect(page).to have_content(I18n.t('shopping_cart.order_items.product.add'))
    end

    it "car" do
      create_list(:car, 3)
      visit(root_path)
      first('#new_order_item').click_button('Add to cart')
      expect(page).to have_current_path(shopping_cart.order_items_path)
      expect(page).to have_content(I18n.t('shopping_cart.order_items.product.add'))
    end
  end
end
