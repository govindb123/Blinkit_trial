class HomeController < ApplicationController
  def index
    if params[:clear_role]
      session[:user_id] = nil
      @current_user = nil
    end
  end

  def set_role
    if params[:role].in?(['customer', 'seller', 'rider'])
      # Find existing user with this role or create new one
      user = User.find_or_create_by(role: params[:role]) do |u|
        u.role = params[:role]
      end
      
      session[:user_id] = user.id
      redirect_to send("#{params[:role]}_path")
    else
      redirect_to root_path, alert: "Invalid role selected"
    end
  end

  private

  def customer_path
    orders_path
  end

  def seller_path
    items_path
  end

  def rider_path
    deliveries_path
  end
end
