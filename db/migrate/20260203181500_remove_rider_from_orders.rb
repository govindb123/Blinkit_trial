class RemoveRiderFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :rider_id, :integer
    remove_column :orders, :rider_name, :string
  end
end