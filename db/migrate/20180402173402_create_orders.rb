class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true
      t.date :orderDate
      t.datetime :deliveryDate
      t.text :deliveryAddress
      t.string :deliveryPhone, limit: 13
      t.integer :status
      t.text :comments
      t.belongs_to :cake_price, foreign_key: true
      t.integer :paidStatus

      t.timestamps
    end
  end
end
