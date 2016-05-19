class AddManufacturerRedToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :manufacturer, index: true, foreign_key: true
  end
end
