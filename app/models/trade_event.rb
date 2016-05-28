class TradeEvent < ActiveRecord::Base
  has_one :address, as: :addressable
  belongs_to :buyer
  has_many :attending_manufacturers
  has_many :manufacturers, through: :attending_manufacturers

  accepts_nested_attributes_for :address
  validates_presence_of :event_name
  default_scope { order('trade_events.id ASC')}

  scope :user_events, -> (user) { where buyer_id: user }
  scope :by_event_name, -> (event_name) { where("event_name LIKE ?", "%#{event_name}%") }
  scope :by_city, -> (city) { joins(:address).where("addresses.city LIKE ?", "%#{city}%").references(:addresses) }
  # scope :in_date_range, lambda { |start_date, end_date| where("(status_date >= ?) AND (status_date <= ?)", start_date, end_date) }
  # scope :in_date_range, ->(start_date = Date.ordinal(1900, 1), end_date = Date.ordinal(2999,365)) { where("end_date >= ? AND start_date <= ?", start_date, end_date) }
end
