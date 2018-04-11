class CreateCakePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :cake_prices do |t|
      t.belongs_to :cake, foreign_key: true
      t.integer :size
      t.float :price
      t.timestamps
    end
  end
end
