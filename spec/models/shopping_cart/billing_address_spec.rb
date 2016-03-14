require 'rails_helper'

RSpec.describe ShoppingCart::BillingAddress, :type => :model do
  it { is_expected.to have_one(:order) }
end
