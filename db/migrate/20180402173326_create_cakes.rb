class CreateCakes < ActiveRecord::Migration[5.1]
  def change
    create_table :cakes do |t|
      t.belongs_to :flavor, foreign_key: true
      t.string :decorationImgURL, limit: 250
      t.text :comments
      t.integer :levels
      t.boolean :gallery

      t.timestamps
    end
  end
end
