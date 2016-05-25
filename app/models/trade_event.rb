class TradeEvent < ActiveRecord::Base
  has_one :address, as: :addressable
  belongs_to :buyer
  has_many :attending_manufacturers
  has_many :manufacturers, through: :attending_manufacturers
  accepts_nested_attributes_for :address
  validates_presence_of :event_name
  default_scope { order('trade_events.id ASC')}

  # def self.search(search)
  #   search_params = "%#{search}%"
  #   joins(:address).find(:all, conditions: ["event_name LIKE ? OR addresses.city LIKE ?", search_params, search_params])
  # end


  #   where("event_name LIKE ?", "%#{search}%") 
  #   # includes(:address).where("address.city LIKE ?", "%#{search}%")
  #   # where("city LIKE ?", "%#{search}%")
  #   joins(:address).where("addresses.city LIKE ?", "%#{search}%").references(:addresses)
  # end

  scope :user_events, -> (user) { where buyer_id: user }
  scope :by_event_name, -> (event_name) { where("event_name LIKE ?", "%#{event_name}%") }
  scope :by_city, -> (city) { joins(:address).where("addresses.city LIKE ?", "%#{city}%").references(:addresses) }
  # scope :in_date_range, lambda { |start_date, end_date| includes([:person, :pier_module]).where("(status_date >= ?) AND (status_date <= ?)", start_date, end_date) }
end
