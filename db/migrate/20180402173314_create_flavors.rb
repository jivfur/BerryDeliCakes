class CreateFlavors < ActiveRecord::Migration[5.1]
  def change
    create_table :flavors do |t|
      t.string :name, limit: 50
      t.string :flavorImgURL, limit: 250

      t.timestamps
    end
  end
end
