class DeliveriesController < ApplicationController
	def index
		@pending_orders = Order.where(status: "pending")
		@delivered_orders = Order.where(status: "delivered")
	end

	def show
		@order = Order.find(params[:id])
		@order_items = @order.order_items.includes(:item)
	end

	def update
		order = Order.find(params[:id])
		order.update(status: "delivered")

		redirect_to deliveries_path
	end
end
