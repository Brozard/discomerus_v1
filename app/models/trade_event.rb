class TradeEvent < ActiveRecord::Base
  has_one :address, as: :addressable
  belongs_to :buyer
  has_many :attending_manufacturers
  has_many :manufacturers, through: :attending_manufacturers
end
