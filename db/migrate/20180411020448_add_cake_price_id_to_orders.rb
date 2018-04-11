class AddCakePriceIdToOrders < ActiveRecord::Migration[5.1]
  def change
    ##add_has_one :orders, :cakeprice, :foreign_key =>true
    add_belongs_to :orders, :cake_price, foreign_key: true
  end
end
