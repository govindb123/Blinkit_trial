class DeliveriesController < ApplicationController
	before_action :require_rider

	def index
		@available_orders = Order.where(status: "pending")
		@my_assigned_orders = Order.where(status: ["assigned", "picked_up", "in_transit", "nearby"])
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

	def pickup
		order = Order.find_by(id: params[:id])
		return redirect_to deliveries_path, alert: "Order not found" unless order
		
		if order.status == "assigned" && order.update(status: "picked_up")
			redirect_to deliveries_path, notice: "Order picked up"
		else
			redirect_to deliveries_path, alert: "Cannot pick up - order must be assigned first"
		end
	end

	def start_delivery
		order = Order.find_by(id: params[:id])
		return redirect_to deliveries_path, alert: "Order not found" unless order
		
		if order.status == "picked_up" && order.update(status: "in_transit")
			redirect_to deliveries_path, notice: "Delivery started"
		else
			redirect_to deliveries_path, alert: "Cannot start delivery - order must be picked up first"
		end
	end

	def nearby
		order = Order.find_by(id: params[:id])
		return redirect_to deliveries_path, alert: "Order not found" unless order
		
		if order.status == "in_transit" && order.update(status: "nearby")
			redirect_to deliveries_path, notice: "Marked as nearby"
		else
			redirect_to deliveries_path, alert: "Cannot mark nearby - order must be in transit first"
		end
	end

	def update
		order = Order.find_by(id: params[:id])
		return redirect_to deliveries_path, alert: "Order not found" unless order
		
		if order.status == "nearby" && order.update(status: "delivered")
			redirect_to deliveries_path, notice: "Order marked as delivered"
		else
			redirect_to deliveries_path, alert: "Cannot deliver - order must be nearby first"
		end
	end
end
