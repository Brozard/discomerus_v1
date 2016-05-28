class RemovePictureFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :picture, :string
  end
end
