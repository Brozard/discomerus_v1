class Buyer < ActiveRecord::Base
  has_many :trade_events
end
