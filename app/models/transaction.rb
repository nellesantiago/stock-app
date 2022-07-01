class Transaction < ApplicationRecord
  after_validation :set_total_stock_price
  validates :order_quantity, numericality: {greater_than: 0}
  belongs_to :user

  enum transaction_type: {buy: 0, sell: 1}, _prefix: true

  def set_total_stock_price
    self.total_stock_price = self.order_quantity.to_d * self.stock_price.to_d
  end
end
