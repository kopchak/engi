FactoryGirl.define do
  factory :shopping_cart_order_item, :class => 'ShoppingCart::OrderItem' do
    price { Faker::Commerce.price }
    quantity { Faker::Number.between(1, 5) }
  end
end