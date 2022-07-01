class UserStock < ApplicationRecord
  after_validation :set_total_stock_price
  validates :order_quantity, numericality: {greater_than_or_equal_to: 0, message: "Insufficient"}

  belongs_to :user

  def set_total_stock_price
    self.total_stock_price = self.order_quantity.to_d * self.stock_price.to_d
  end
end
