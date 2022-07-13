class RemoveStockPriceToUserStocks < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_stocks, :stock_price
  end
end
