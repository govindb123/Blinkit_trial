class OrdersController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @order = Order.find_by(id: params[:id])
    return redirect_to orders_path, alert: "Order not found" unless @order
    @order_items = @order.order_items.includes(:item)
  end

  def create
    item = Item.find_by(id: params[:item_id])
    return redirect_to orders_path, alert: "Item not found" unless item
    
    order = Order.create(status: "pending", address: params[:address])
    if order.persisted?
      OrderItem.create(order: order, item: item, quantity: 1)
      redirect_to orders_path, notice: "Your order is confirmed! Order ##{order.id}"
    else
      redirect_to orders_path, alert: "Failed to create order"
    end
  end
end

