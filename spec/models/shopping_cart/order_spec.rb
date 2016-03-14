require 'rails_helper'

RSpec.describe ShoppingCart::Order, :type => :model do
  before do
    @order = create(:shopping_cart_order)
  end

  it { is_expected.to belong_to(:customer) }
  it { is_expected.to belong_to(:delivery) }
  it { is_expected.to belong_to(:discount) }
  it { is_expected.to belong_to(:credit_card) }
  it { is_expected.to have_many(:order_items) }
  it { is_expected.to belong_to(:billing_address) }
  it { is_expected.to belong_to(:shipping_address) }
  it { is_expected.to accept_nested_attributes_for(:credit_card) }
  it { is_expected.to accept_nested_attributes_for(:billing_address) }
  it { is_expected.to accept_nested_attributes_for(:shipping_address) }

  context 'state' do
    it 'after create state is in_progress' do
      expect(@order.in_progress?).to be_truthy
    end

    it 'can transition from in_progress to in_queue' do
      expect(@order.may_in_queue?).to be_truthy
    end

    it 'cannot skip in_queue state' do
      expect(@order.may_in_delivery?).to be_falsey
    end

    it 'can transition from in_queue to in_delivery' do
      @order.in_queue
      expect(@order.may_in_delivery?).to be_truthy
    end

    it 'cannot skip in_delivery state' do
      expect(@order.may_delivered?).to be_falsey
    end

    it 'can transition from in_delivery to delivered' do
      @order.in_queue
      @order.in_delivery
      expect(@order.may_delivered?).to be_truthy
    end

    it 'can transition from in_progress to canceled' do
      expect(@order.may_canceled?).to be_truthy
    end

    it 'can transition from in_queue to canceled' do
      @order.in_queue
      expect(@order.may_canceled?).to be_truthy
    end

    it 'cannot transition from in_delivery to canceled' do
      @order.in_queue
      @order.in_delivery
      expect(@order.may_canceled?).to be_falsey
    end

    it 'cannot transition from delivered to canceled' do
      @order.in_queue
      @order.in_delivery
      @order.delivered
      expect(@order.may_canceled?).to be_falsey
    end
  end

  context '#items_price' do
    before do
      order_item1 = create(:shopping_cart_order_item, order_id: @order.id)
      order_item2 = create(:shopping_cart_order_item, order_id: @order.id)
      order_item3 = create(:shopping_cart_order_item, order_id: @order.id)
      @sum_order_items = order_item1.price + order_item2.price + order_item3.price
    end

    it 'get sum of all order items' do
      expect(@order.items_price.to_f).to eq(@sum_order_items.to_f)
    end

    it 'get zero sum if no has order items' do
      @order.order_items.destroy_all
      expect(@order.items_price.to_f).to eq(0)
    end
  end

  context '#items_quantity' do
    before do
      order_item1 = create(:shopping_cart_order_item, order_id: @order.id)
      order_item2 = create(:shopping_cart_order_item, order_id: @order.id)
      order_item3 = create(:shopping_cart_order_item, order_id: @order.id)
      @quantity_order_items = order_item1.quantity + order_item2.quantity + order_item3.quantity
    end

    it 'get quantity of all order items' do
      expect(@order.items_quantity).to eq(@quantity_order_items)
    end

    it 'get zero if there is no order items' do
      @order.order_items.destroy_all
      expect(@order.items_quantity).to eq(0)
    end
  end

  context '#add_product' do
    before do
      @book = create(:book)
      @book_qty = 2
      @order_item_price = @book.price * @book_qty
      @order.add_product(@book, @book_qty)
    end

    it 'first time' do
      expect(@order.order_items.first.quantity).to eq(@book_qty)
      expect(@order.items_price).to eq(@order_item_price)
    end

    it 'second time' do
      @order.add_product(@book, @book_qty)
      expect(@order.order_items.first.quantity).to eq(@book_qty * 2)
      expect(@order.items_price).to eq(@order_item_price * 2)
    end
  end

  context '#add_discount' do
    before do
      @discount = create(:shopping_cart_discount)
      @order.add_discount(@discount)
    end

    it 'first time' do
      expect(@order.discount).not_to be_nil
    end

    it 'second time' do
      discount = create(:shopping_cart_discount)
      @order.add_discount(discount)
      expect(@order.discount.id).not_to eq(discount.id)
      expect(@order.discount.id).to eq(@discount.id)
    end
  end

  context '#set_total_price' do
    before do
      @delivery = create(:shopping_cart_delivery)
      @order = create(:shopping_cart_order, delivery_id: @delivery.id)
      order_item1 = create(:shopping_cart_order_item, order_id: @order.id)
      order_item2 = create(:shopping_cart_order_item, order_id: @order.id)
    end

    it 'result total price when exist discount' do
      @discount = create(:shopping_cart_discount)
      @order.add_discount(@discount)
      total_price_with_discount = @order.items_price + @delivery.price - @discount.amount
      @order.set_total_price
      expect(@order.total_price).to eq(total_price_with_discount)
    end

    it 'result total price without discount' do
      total_price_without_discount = @order.items_price + @delivery.price
      @order.set_total_price
      expect(@order.total_price).to eq(total_price_without_discount)
    end
  end

  context '#confirm' do
    before do
      @customer = create(:user)
    end

    it 'assign the customer' do
      expect(@order.customer).to be_nil
      @order.confirm(@customer)
      expect(@order.customer).not_to be_nil
    end

    it 'after confirm has state in_queue' do
      @order.confirm(@customer)
      expect(@order.state).to eq('in_queue')
    end

    it 'after confirm has competed date 3 days from now' do
      date = (3.days.from_now).to_date
      @order.confirm(@customer)
      expect(@order.completed_date).to eq(date)
    end
  end

end
