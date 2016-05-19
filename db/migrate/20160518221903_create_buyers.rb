class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :company_name
      t.string :agent_name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
