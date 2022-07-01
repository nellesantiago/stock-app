class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :company_name
      t.string :logo_url

      t.timestamps
    end
  end
end
