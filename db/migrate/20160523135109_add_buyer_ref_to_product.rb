class AddBuyerRefToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :buyer, index: true, foreign_key: true
  end
end
