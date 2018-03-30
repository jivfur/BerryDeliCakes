class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :userName, limit: 12
      t.string :password, limit: 50
      t.boolean :role
      t.string :name, limit: 80
      t.string :lastName, limit: 80
      t.string :phone, limit: 12
      t.string :email
      t.text :address

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
