FactoryGirl.define do
  factory :shopping_cart_order, :class => 'ShoppingCart::Order' do
    completed_date { Faker::Date.forward(10) }
  end
end
