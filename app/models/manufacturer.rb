class Manufacturer < ActiveRecord::Base
  has_one :address, as: :addressable
  has_many :products
  has_many :attending_manufacturers
  has_many :trade_events, through: :attending_manufacturers

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :attending_manufacturers, allow_destroy: true
  validates_presence_of :company_name

  

  # default_scope { order('manufacturers.id ASC')}
  default_scope { order('id ASC')}

  # This scope takes in the Trade Event ids associated with the current user, and is used by the controller to return all Manufacturer records associated with that user
  scope :events_attended, -> (ids_of_user) { includes(:trade_events).where(trade_events: {id: (ids_of_user)}) }
  scope :order_by_company_name, -> { unscoped.order("company_name ASC") }

  scope :by_company_name, -> (company_name) { where("company_name LIKE ?", "%#{company_name}%") }
  scope :by_contact_name, -> (contact_name) { where("contact_name LIKE ?", "%#{contact_name}%") }
  scope :by_shipping_port, -> (shipping_port) { where("shipping_port LIKE ?", "%#{shipping_port}%") }
  # scope :by_city, -> (city) { joins(:address).where("addresses.city LIKE ?", "%#{city}%").references(:addresses) }
end
