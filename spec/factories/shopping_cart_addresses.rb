FactoryGirl.define do
  factory :shopping_cart_address, :class => 'ShoppingCart::Address' do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    country { Faker::Address.country }
    zipcode { Faker::Address.zip_code }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
