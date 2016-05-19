class AddBuyerRefToTradeEvent < ActiveRecord::Migration
  def change
    add_reference :trade_events, :buyer, index: true, foreign_key: true
  end
end
