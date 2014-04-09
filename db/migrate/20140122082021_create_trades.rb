class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.decimal :credit, default: 0
      t.decimal :debit, default: 0
      t.string :trade_type
      t.integer :order_id
      t.integer :user_id

      t.timestamps
    end
  end
end
