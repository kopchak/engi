require 'rails_helper'

RSpec.describe ShoppingCart::ShippingAddress, :type => :model do
  it { is_expected.to have_one(:order) }
end
