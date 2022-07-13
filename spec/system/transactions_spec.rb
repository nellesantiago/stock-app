require 'rails_helper'

RSpec.describe "Transactions", type: :system do
  fixtures :all
  before do
    driven_by(:rack_test)
    @admin = users(:admin)
    @trader = users(:trader)
    visit new_user_session_path
  end

  # trader user story #5
  it "allows trader to buy stocks" do
    sign_in @trader

    visit stocks_path

    first('.box').click

    expect(page).to have_text("AMD")

    fill_in "Quantity", with: "5"

    click_button "Buy"

    visit transactions_path

    expect(page).to have_text("buy")
  end

  # trader user story #8
  it "allows trader to sell stocks" do
    sign_in @trader

    visit user_stocks_path

    first('.sell-icon').click

    expect(page).to have_text("AMD")

    fill_in "Quantity", with: "1"

    click_button "Sell"

    visit transactions_path

    expect(page).to have_text("sell")
  end
  
  # trader user story #7
  it "allows trader to view all transactions" do
    sign_in @trader

    visit transactions_path

    expect(page).to have_text("Transactions")
  end

  # admin user story #7
  it "allows admin to view all traders' transactions" do
    sign_in @admin

    visit admin_transactions_path

    expect(page).to have_text("Transactions")
  end

  it "allows admin to view specific trader's transactions" do
    sign_in @admin

    visit users_path

    first('.show-icon').click

    expect(page).to have_text("Transactions")
  end

  it "doesn't allow admin to buy stocks" do
    sign_in @admin

    visit stocks_path

    first('.box').click

    expect(page).to have_text("Function is only for traders!")
  end
end
