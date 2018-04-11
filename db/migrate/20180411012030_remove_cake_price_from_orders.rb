class RemoveCakePriceFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_reference :orders, :cake_price, foreign_key: true
  end
end
