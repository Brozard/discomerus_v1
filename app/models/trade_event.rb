class TradeEvent < ActiveRecord::Base
  has_one :address, as: :addressable
  belongs_to :buyer
  has_many :attending_manufacturers
  has_many :manufacturers, through: :attending_manufacturers
  accepts_nested_attributes_for :address
  validates_presence_of :event_name
  default_scope { order('id ASC')}
end
