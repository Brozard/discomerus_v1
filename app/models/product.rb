class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :buyer
  default_scope { order('id ASC')}
end
