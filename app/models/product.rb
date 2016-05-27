class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :buyer
  belongs_to :category
  has_many :pictures

  default_scope { order('id ASC')}

  def num_check(num)
    if num.first.nil?
      nil
    else
      num.first
    end
  end

  scope :user_products, -> (user) { where buyer_id: user }

  scope :by_name, -> (name) { where("name LIKE ?", "%#{name}%") }
  scope :by_price, -> (min_price, max_price) { where("price >= ? AND price <= ?", (min_price.to_d * 100).to_i, (max_price.to_d * 100).to_i) }
  # scope :by_category, -> (category) { joins(:category).where("categories.category LIKE ?", "%#{category}%").references(:categories) }
end
