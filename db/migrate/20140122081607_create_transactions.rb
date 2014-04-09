class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :credit, default: 0
      t.decimal :debit, default: 0
      t.string :address
      t.string :transaction_hash
      t.string :currency_type
      t.integer :user_id
      t.boolean :processed

      t.timestamps
    end
  end
end
