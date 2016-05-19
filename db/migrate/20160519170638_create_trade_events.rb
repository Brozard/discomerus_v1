class CreateTradeEvents < ActiveRecord::Migration
  def change
    create_table :trade_events do |t|
      t.string :event_name
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
