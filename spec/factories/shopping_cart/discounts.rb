FactoryGirl.define do
  factory :shopping_cart_discount, :class => 'ShoppingCart::Discount' do
    code { Faker::Number.number(6) }
    amount { Faker::Number.between(5, 10) }
  end
end
