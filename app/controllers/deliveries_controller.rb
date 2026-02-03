class DeliveriesController < ApplicationController
	before_action :ensure_rider_session

	def index
		@available_orders = Order.where(status: "pending")
		@my_assigned_orders = Order.where(status: ["assigned", "out_for_delivery"])
		@delivered_orders = Order.where(status: "delivered")
	end

	def show
		@order = Order.find_by(id: params[:id])
		return redirect_to deliveries_path, alert: "Order not found" unless @order
		@order_items = @order.order_items.includes(:item)
	end

	def assign
		order = Order.find_by(id: params[:id])
		return redirect_to deliveries_path, alert: "Order not found" unless order
		
		if order.update(status: "assigned")
			redirect_to deliveries_path, notice: "Order assigned to you"
		else
			redirect_to deliveries_path, alert: "Failed to assign order"
		end
	end

	def start_delivery
		order = Order.find_by(id: params[:id])
		return redirect_to deliveries_path, alert: "Order not found" unless order
		
		# For demo purposes, allow any rider to start any assigned order
		if order.status == "assigned" && order.update(status: "out_for_delivery")
			redirect_to deliveries_path, notice: "Delivery started"
		else
			redirect_to deliveries_path, alert: "Cannot start delivery - order must be assigned first"
		end
	end

	def update
		order = Order.find_by(id: params[:id])
		return redirect_to deliveries_path, alert: "Order not found" unless order
		
		# For demo purposes, allow any rider to deliver any out_for_delivery order
		if order.status == "out_for_delivery" && order.update(status: "delivered")
			redirect_to deliveries_path, notice: "Order marked as delivered"
		else
			redirect_to deliveries_path, alert: "Cannot deliver - order must be out for delivery first"
		end
	end

	private

	def ensure_rider_session
		session[:rider_id] ||= SecureRandom.hex(8)
	end
end
