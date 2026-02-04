class OrdersController < ApplicationController
  before_action :require_customer

  def index
    @items = Item.all
  end

  def show
    @order = Order.find_by(id: params[:id])
    return redirect_to orders_path, alert: "Order not found" unless @order
    @order_items = @order.order_items.includes(:item)
    @progress_steps = [
      { status: 'pending', label: 'Order Confirmed', icon: '⏳' },
      { status: 'assigned', label: 'Rider Assigned', icon: '👤' },
      { status: 'picked_up', label: 'Picked Up', icon: '📦' },
      { status: 'in_transit', label: 'On the Way', icon: '🚚' },
      { status: 'nearby', label: 'Nearby', icon: '📍' },
      { status: 'delivered', label: 'Delivered', icon: '✅' }
    ]
  end

  def create
    item = Item.find_by(id: params[:item_id])
    return redirect_to orders_path, alert: "Item not found" unless item
    
    quantity = params[:quantity].to_i
    quantity = 1 if quantity < 1
    
    order = Order.create(status: "pending", address: params[:address])
    if order.persisted?
      OrderItem.create(order: order, item: item, quantity: quantity)
      redirect_to orders_path, notice: "Your order is confirmed! Order ##{order.id} (#{quantity} x #{item.name})"
    else
      redirect_to orders_path, alert: "Failed to create order"
    end
  end
end

