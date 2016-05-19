class AttendingManufacturer < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :trade_event
end
