class CarsController < ApplicationController
  def index
    @cars = Car.all
    @order_item = ShoppingCart::OrderItem.new
  end
end
