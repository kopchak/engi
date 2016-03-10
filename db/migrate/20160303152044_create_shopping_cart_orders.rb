class CreateShoppingCartOrders < ActiveRecord::Migration
  def change
    create_table :shopping_cart_orders do |t|
      t.decimal    :total_price, precision: 6, scale: 2
      t.date       :completed_date
      t.string     :state
      t.references :customer, polymorphic: true
      t.references :delivery, index: true
      t.references :discount, index: true
      t.references :credit_card, index: true
      t.integer :billing_address_id,  index: true
      t.integer :shipping_address_id, index: true

      t.timestamps null: false
    end
    add_foreign_key :orders, :discounts
    add_foreign_key :orders, :deliveries
    add_foreign_key :orders, :credit_cards
  end
end
