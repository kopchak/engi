class CreateShoppingCartDeliveries < ActiveRecord::Migration
  def change
    create_table :shopping_cart_deliveries do |t|
      t.decimal :price, precision: 5, scale: 2
      t.string  :title

      t.timestamps null: false
    end
  end
end
