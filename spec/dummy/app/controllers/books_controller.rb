class BooksController < ApplicationController
  def index
    @books = Book.all
    @order_item = ShoppingCart::OrderItem.new
  end
end
