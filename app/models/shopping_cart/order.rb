module ShoppingCart
  class Order < ActiveRecord::Base
    include AASM
    belongs_to :customer, polymorphic: true
    belongs_to :delivery
    belongs_to :discount,    dependent: :destroy
    belongs_to :credit_card, dependent: :destroy
    has_many   :order_items, dependent: :destroy
    belongs_to :billing_address,  class_name: "Address", dependent: :destroy
    belongs_to :shipping_address, class_name: "Address", dependent: :destroy

    after_create :create_address_and_credit_card

    accepts_nested_attributes_for :billing_address
    accepts_nested_attributes_for :shipping_address
    accepts_nested_attributes_for :credit_card

    aasm column: :state do
      state :in_progress, initial: true
      state :in_queue
      state :in_delivery
      state :delivered
      state :canceled

      event :in_queue do
        transitions from: :in_progress, to: :in_queue
      end

      event :in_delivery do
        transitions from: :in_queue, to: :in_delivery
      end

      event :delivered do
        transitions from: :in_delivery, to: :delivered
      end

      event :canceled do
        transitions from: [:in_progress, :in_queue], to: :canceled
      end
    end

    def state_enum
      ['in_queue', 'in_delivery', 'delivered', 'canceled']
    end

    def items_price
      self.order_items.sum(:price)
    end

    def items_quantity
      self.order_items.sum(:quantity)
    end

    def add_product(product, qty)
      if order_item = self.order_items.find_by(product: product)
        order_item.quantity += qty
        order_item.price += order_item.product.price * qty
      else
        order_item = self.order_items.new(product: product, quantity: qty)
        order_item.price = order_item.product.price * qty
      end
      order_item.save
    end

    def add_discount(coupon)
      if coupon.new_state && self.discount.nil?
        coupon.update(new_state: false)
        self.discount = coupon
        self.save
      end
    end

    def set_total_price
      if self.discount
        self.total_price = self.items_price + self.delivery.price - self.discount.amount
      else
        self.total_price = self.items_price + self.delivery.price
      end
      self.save
    end

    def confirm(current_user)
      self.customer = current_user
      self.in_queue
      self.completed_date = 3.days.from_now
      self.save
    end

    private
    def create_address_and_credit_card
      self.build_billing_address
      self.build_shipping_address
      self.build_credit_card
      self.save
    end
  end
end
