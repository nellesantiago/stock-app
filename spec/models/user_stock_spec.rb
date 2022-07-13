require 'rails_helper'

RSpec.describe UserStock, type: :model do
  subject {
    UserStock.new(
      order_quantity: 0
    )
  }

  it "is not valid with a negative order quantity" do
    subject.order_quantity = -1
    expect(subject).to_not be_valid
  end
end
