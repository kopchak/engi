class CreateShoppingCartDiscounts < ActiveRecord::Migration
  def change
    create_table :shopping_cart_discounts do |t|
      t.string  :code,      null:    false
      t.integer :amount,    null:    false
      t.boolean :new_state, default: true

      t.timestamps null: false
    end
  end
end
