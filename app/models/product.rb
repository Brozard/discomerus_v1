class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :buyer
  has_many :pictures
  default_scope { order('id ASC')}
end
