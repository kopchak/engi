FactoryGirl.define do
  factory :shopping_cart_delivery, :class => 'ShoppingCart::Delivery' do
    price { Faker::Commerce.price }
    title { Faker::Name.title }
  end
end
