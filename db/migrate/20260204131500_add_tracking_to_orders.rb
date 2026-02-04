class AddTrackingToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :status_updated_at, :datetime
    add_column :orders, :estimated_delivery_time, :datetime
    add_column :orders, :delivery_notes, :text
  end
end