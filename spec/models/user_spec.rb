require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    User.new(
      first_name: "Model",
      last_name: "Testing",
      email: "modeltesting@gmail.com",
      password: "1234567890",
      password_confirmation: "1234567890",
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not a valid password with less than 6 characters" do
    subject.password = "12345"
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    subject.password_confirmation = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a first name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a negative balance" do
    subject.balance = -1
    expect(subject).to_not be_valid
  end
end
