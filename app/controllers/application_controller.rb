class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user
    @current_user
  end
  helper_method :current_user

  def require_role(role)
    unless current_user&.role == role.to_s
      redirect_to root_path, alert: "Access denied. Please select #{role.capitalize} role."
    end
  end

  def require_customer
    require_role(:customer)
  end

  def require_seller
    require_role(:seller)
  end

  def require_rider
    require_role(:rider)
  end
end
