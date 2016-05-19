class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :item_number
      t.integer :price
      t.text :description
      t.integer :min_order_quantity

      t.timestamps null: false
    end
  end
end
