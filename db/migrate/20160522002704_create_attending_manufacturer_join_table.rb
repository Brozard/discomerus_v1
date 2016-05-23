class CreateAttendingManufacturerJoinTable < ActiveRecord::Migration
  def change
    create_table :attending_manufacturers, id: false do |t|
      t.integer :trade_event_id
      t.integer :manufacturer_id
    end
 
    add_index :attending_manufacturers, :trade_event_id
    add_index :attending_manufacturers, :manufacturer_id
  end
end
