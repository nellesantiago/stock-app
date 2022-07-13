class RemoveTotalStockPriceToUserStocks < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_stocks, :total_stock_price
  end
end
