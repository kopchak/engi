FactoryGirl.define do
  factory :car do
    name  { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
  end
end