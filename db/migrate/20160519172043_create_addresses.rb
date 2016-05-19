class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :street_address_1
      t.string :street_address_2
      t.string :street_address_3
      t.string :city
      t.string :district
      t.string :state
      t.string :postal_code
      t.references :addressable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
