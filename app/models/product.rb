class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :buyer
  belongs_to :category
  has_many :pictures

  # If a Product record has a nil Category ID value, display an empty String. Otherwise, display the corresponding Category for the ID.
  def show_category
    category_id == nil ? "" : category.category_name
  end

  # By default, the Products table should return by ID. This can be unscopped and sorted by Product Name instead.
  default_scope { order('id ASC')}
  scope :order_by_product_name, -> { unscoped.order("name ASC") }

  # This scope is used by the controller to retrieve only the Products that are associated with the current user (Buyer).
  scope :user_products, -> (user) { where buyer_id: user }

  # Below are the scopes for the Products index filters.
  scope :by_name, -> (name) { where("LOWER(name) LIKE ?", "%#{name}%") }
  scope :by_price, -> (min_price, max_price) { where("price >= ? AND price <= ?", (min_price.to_d * 100).to_i, (max_price.to_d * 100).to_i) }
  scope :by_category, -> (category) { where("category_id = ?", category.to_i) }

end
