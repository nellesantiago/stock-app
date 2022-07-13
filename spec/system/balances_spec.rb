require 'rails_helper'

RSpec.describe "Balances", type: :system do
  fixtures :all
  before do
    driven_by(:rack_test)
    @trader = users(:trader)
    visit new_user_session_path
    sign_in @trader
  end

  it "allows trader to view their balance" do
    visit dashboard_path

    expect(page).to have_text("Total balance")
  end

  it "allows trader to top up" do
    visit dashboard_path

    click_on "Top Up"

    expect(page).to have_text("Current Balance:")
    
    fill_in "Enter Amount", with: 1

    click_button "Top Up"

    expect(page).to have_text("$1,000,001.00")
  end
  
end
