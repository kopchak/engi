Rails.application.routes.draw do

  devise_for :users
  mount ShoppingCart::Engine => "/shopping_cart"

  resources :books, only: :index
  root "cars#index"
end
