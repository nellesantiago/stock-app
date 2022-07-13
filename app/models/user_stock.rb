class UserStock < ApplicationRecord
  validates :order_quantity, numericality: {greater_than_or_equal_to: 0, message: "Insufficient"}

  belongs_to :user

  def get_price
    Stock.find_by(symbol: self.stock_symbol).get_quote.latest_price
  end

  def get_total
    self.order_quantity.to_d * self.get_price.to_d
  end

  def clear_stock
    self.destroy unless self.order_quantity.nonzero?
  end
end
