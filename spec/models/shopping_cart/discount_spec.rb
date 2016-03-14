require 'rails_helper'

RSpec.describe ShoppingCart::Discount, :type => :model do
  it { is_expected.to have_one(:order) }
  it { is_expected.to validate_presence_of(:amount) }

  it 'after create code not nil' do
    discount = create(:shopping_cart_discount)
    expect(discount.code).not_to be_nil
  end
end
