class RemoveAttendingManufacturers < ActiveRecord::Migration
  def up
    drop_table :attending_manufacturers
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't recover deleted table, recreated in later migration."
  end
end
