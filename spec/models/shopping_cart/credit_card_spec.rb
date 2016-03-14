require 'rails_helper'

RSpec.describe ShoppingCart::CreditCard, :type => :model do
  it { is_expected.to have_one(:order) }
  it { is_expected.to validate_presence_of(:number).on(:update) }
  it { is_expected.to validate_presence_of(:expiration_month).on(:update) }
  it { is_expected.to validate_presence_of(:expiration_year).on(:update) }
  it { is_expected.to validate_presence_of(:cvv).on(:update) }
end
