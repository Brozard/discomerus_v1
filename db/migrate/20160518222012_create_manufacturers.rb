class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :company_name
      t.string :contact_name
      t.string :email
      t.string :phone_number
      t.string :shipping_port

      t.timestamps null: false
    end
  end
end
