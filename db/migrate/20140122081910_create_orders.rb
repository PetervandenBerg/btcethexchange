class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :credit, default: 0
      t.decimal :debit, default: 0
      t.decimal :exchange_rate
      t.string :trade_type
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
