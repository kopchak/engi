
# ShoppingCart

Simple Ruby On Rails plugin based on Rails Engine

## Installation
Add this line to your application gemfile

```ruby
  gem 'shopping_cart', git: 'https://github.com/kopchak/engi.git'
```
and then execute:
```
  $ bundle install
```


Edit your `app/controller/application_controller.rb` and add a current_user method, unless you are using the Devise gem.

## Usage

### Initialization

add this line to your config/routes.rb
```ruby
  mount ShoppingCart::Engine, at: '/shopping_cart'
```

Create database structure:

```ruby
  rake shopping_cart:install:migrations
  rake db:migrate
```

Add to your User model:

```ruby
  class User < ActiveRecord::Base
    ...
    acts_as_customer
  end
```

Add to your product models:

```ruby
  class Book < ActiveRecord::Base
    ...
    acts_as_product
  end
```

```ruby
  class Car < ActiveRecord::Base
    ...
    acts_as_product
  end
```

Also need to create types of delivery:
```ruby
  ShoppingCart::Delivery.create(
    [{title: 'UPS Ground', price: 5}, {title: 'UPS Two Day', price: 10}, {title: 'UPS One Day', price: 15}]
  )
```

###Helpers

add car to cart
```ruby
  <%= form_for ShoppingCart::OrderItem.new, url: shopping_cart.order_items_path(car_id: car.id) do |f| %>
    <%= f.number_field :quantity, value: 1, min: 1, max: 10 %>
    <%= f.submit 'Add to cart' %>
  <% end %>
```

add book to cart
```ruby
  <%= form_for ShoppingCart::OrderItem.new, url: shopping_cart.order_items_path(book_id: book.id) do |f| %>
    <%= f.number_field :quantity, value: 1, min: 1, max: 10 %>
    <%= f.submit 'Add to cart' %>
  <% end %>
```

Add a link to the cart:

```ruby
  <%= link_to 'Cart', shopping_cart.order_items_path %>
```

Add a link to the orders history:

```ruby
  <%= link_to 'Orders', shopping_cart.orders_path %>
```

### Controllers

You can generate controllers for customization to `app/controllers/shopping_cart`:
```
  $ rails generate shopping_cart:controllers
```


### Views

You can generate views for customization to `app/views/shopping_cart`:
```
  $ rails generate shopping_cart:views
```



## Tests
```
  $ bundle exec rspec
```

This project rocks and uses MIT-LICENSE.
