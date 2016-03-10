class CreateShoppingCartCreditCards < ActiveRecord::Migration
  def change
    create_table :shopping_cart_credit_cards do |t|
      t.string     :number
      t.string     :expiration_month
      t.string     :expiration_year
      t.string     :cvv

      t.timestamps null: false
    end
  end
end
