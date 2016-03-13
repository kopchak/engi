FactoryGirl.define do
  factory :book do
    name  { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
  end
end