class UserStock < ApplicationRecord
  after_validation :set_total_stock_price

  belongs_to :user

  def set_total_stock_price
    self.total_stock_price = self.order_quantity.to_d * self.stock_price
  end
end
