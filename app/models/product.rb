class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :buyer
  belongs_to :category
  has_many :pictures

  default_scope { order('id ASC')}

  scope :user_products, -> (user) { where buyer_id: user }

  scope :by_name, -> (name) { where("name LIKE ?", "%#{name}%") }
  scope :by_price, -> (price) { where("price LIKE ?", "%#{price}%") }
  # scope :by_category, -> (category) { joins(:category).where("categories.category LIKE ?", "%#{category}%").references(:categories) }
end
