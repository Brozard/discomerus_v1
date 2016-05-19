class AddColumnsToAttendingManufacturer < ActiveRecord::Migration
  def change
    add_column :attending_manufacturers, :trade_event_id, :integer
    add_column :attending_manufacturers, :manufacturer_id, :integer
  end
end
