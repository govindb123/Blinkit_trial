class AddRiderIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :rider_id, :integer
    add_column :orders, :rider_name, :string
  end
end