class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :buyer
  belongs_to :category
  has_many :pictures

  


  def show_category
    category_id == nil ? "" : category.category_name
  end

  default_scope { order('id ASC')}

  scope :order_by_product_name, -> { unscoped.order("name ASC") }

  scope :user_products, -> (user) { where buyer_id: user }

  scope :by_name, -> (name) { where("name LIKE ?", "%#{name}%") }
  scope :by_price, -> (min_price, max_price) { where("price >= ? AND price <= ?", (min_price.to_d * 100).to_i, (max_price.to_d * 100).to_i) }
  scope :by_category, -> (category) { where("category_id = ?", category.to_i) }

end
