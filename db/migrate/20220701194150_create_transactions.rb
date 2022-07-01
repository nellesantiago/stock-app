class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type
      t.string :stock_symbol
      t.integer :order_quantity
      t.decimal :stock_price
      t.decimal :total_stock_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
