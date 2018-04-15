class RemoveOrderDateFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :orderDate
  end
end
