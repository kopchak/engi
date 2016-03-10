ShoppingCart::Engine.routes.draw do
  resources :order_items, except: [:new, :show, :edit]

  resources :orders, only: [:index, :show] do
    member do
      get    :complete
      patch  :add_discount
    end
    delete :clear_cart, on: :collection
  end

  namespace :checkouts do
    get   :edit_address
    patch :update_address

    get   :choose_delivery
    patch :set_delivery

    get   :confirm_payment
    patch :update_credit_card

    get   :overview
    get   :confirmation
  end

  root 'order_items#index'
end
