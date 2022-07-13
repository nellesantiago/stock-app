require 'rails_helper'

RSpec.describe "Stocks", type: :system do
  fixtures :all
  before do
    driven_by(:rack_test)
    @admin = users(:admin)
    @trader = users(:trader)
    visit new_user_session_path
  end

  it "allows trader to view all stocks" do
    sign_in @trader

    visit stocks_path
    
    expect(page).to have_current_path(stocks_path)
  end

  it "allows admin to view all stocks" do
    sign_in @admin

    visit stocks_path
    
    expect(page).to have_current_path(stocks_path)
  end

  it "allows trader to get stock quote" do
    sign_in @trader

    visit stocks_path

    first('.box').click

    expect(page).to have_text("Stock Price:")
  end
end
