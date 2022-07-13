require 'rails_helper'

RSpec.describe "UserStocks", type: :system do
  fixtures :all
  before do
    driven_by(:rack_test)
    visit new_user_session_path
    @admin = users(:admin)
    @trader = users(:trader)
  end

  # trader user story #6
  it "allows trader to view his/her porfolio" do
    sign_in @trader

    visit user_stocks_path

    expect(page).to have_text("My Portfolio")
  end

  # admin user story #3
  it "allows admin to view trader's portfolio" do
    sign_in @admin

    visit users_path

    first('.show-icon').click

    expect(page).to have_text("Portfolio")
  end
end
