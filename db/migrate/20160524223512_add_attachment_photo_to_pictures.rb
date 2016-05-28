class AddAttachmentPhotoToPictures < ActiveRecord::Migration
  def self.up
    change_table :pictures do |t|
      t.references :product, index: true, foreign_key: true
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :pictures, :photo
    remove_reference :pictures, :product
  end
end

# def self.up
#    add_attachment :products, :photo
#  end
#
#  def self.down
#    remove_attachment :products, :photo
#  end
# end
