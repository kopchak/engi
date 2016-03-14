require 'rails_helper'

RSpec.describe ShoppingCart::OrderItem, :type => :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:order) }
  it { is_expected.to validate_presence_of(:quantity) }

  context '#calc_price' do
    before do
      book = create(:book)
      @order_item = create(:shopping_cart_order_item, product: book)
      @result = @order_item.calc_price(2)
    end

    it 'get multiplication result' do
      expect(@order_item.calc_price(2)).to eq(@result)
    end
  end
end
