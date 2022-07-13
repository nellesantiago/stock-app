require 'rails_helper'

RSpec.describe Transaction, type: :model do
  subject {
    Transaction.new(
      order_quantity: 0
    )
  }

  it "is not valid with a negative order quantity" do
    subject.order_quantity = -1
    expect(subject).to_not be_valid
  end
end
