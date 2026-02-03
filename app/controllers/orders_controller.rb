class OrdersController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:item)
  end

  def create
    item = Item.find(params[:item_id])
    order = Order.create(status: "pending", address: params[:address])
    OrderItem.create(order: order, item: item, quantity: 1)
    redirect_to orders_path, notice: "Your order is confirmed! Order ##{order.id}"
  end
end

