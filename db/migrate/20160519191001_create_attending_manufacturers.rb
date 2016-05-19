class CreateAttendingManufacturers < ActiveRecord::Migration
  def change
    create_table :attending_manufacturers do |t|

      t.timestamps null: false
    end
  end
end
