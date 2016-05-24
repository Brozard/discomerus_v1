class Manufacturer < ActiveRecord::Base
  has_one :address, as: :addressable
  has_many :products
  has_many :attending_manufacturers
  has_many :trade_events, through: :attending_manufacturers
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :attending_manufacturers, allow_destroy: true
  validates_presence_of :company_name
  default_scope { order('manufacturers.id ASC')}
end
