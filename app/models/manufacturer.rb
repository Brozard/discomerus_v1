class Manufacturer < ActiveRecord::Base
  has_one :address, as: :addressable
  has_many :products
  has_many :attending_manufacturers
  has_many :trade_events, through: :attending_manufacturers
  accepts_nested_attributes_for :address
  validates_presence_of :company_name
end
