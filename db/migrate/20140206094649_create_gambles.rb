class CreateGambles < ActiveRecord::Migration
  def change
    create_table :gambles do |t|
      t.integer :amount
      t.string :currency_type
      t.integer :user_id
      t.boolean :won

      t.timestamps
    end
  end
end
