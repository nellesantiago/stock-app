class CreateUserStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_stocks do |t|
      t.string :stock_symbol
      t.string :company_name
      t.integer :order_quantity
      t.decimal :stock_price
      t.decimal :total_stock_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
