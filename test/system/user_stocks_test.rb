require "application_system_test_case"

class UserStocksTest < ApplicationSystemTestCase
  setup do
    @user_stock = user_stocks(:one)
  end

  test "visiting the index" do
    visit user_stocks_url
    assert_selector "h1", text: "User Stocks"
  end

  test "creating a User stock" do
    visit user_stocks_url
    click_on "New User Stock"

    fill_in "Company name", with: @user_stock.company_name
    fill_in "Order quantity", with: @user_stock.order_quantity
    fill_in "Stock price", with: @user_stock.stock_price
    fill_in "Stock symbol", with: @user_stock.stock_symbol
    fill_in "Total stock price", with: @user_stock.total_stock_price
    fill_in "User", with: @user_stock.user_id
    click_on "Create User stock"

    assert_text "User stock was successfully created"
    click_on "Back"
  end

  test "updating a User stock" do
    visit user_stocks_url
    click_on "Edit", match: :first

    fill_in "Company name", with: @user_stock.company_name
    fill_in "Order quantity", with: @user_stock.order_quantity
    fill_in "Stock price", with: @user_stock.stock_price
    fill_in "Stock symbol", with: @user_stock.stock_symbol
    fill_in "Total stock price", with: @user_stock.total_stock_price
    fill_in "User", with: @user_stock.user_id
    click_on "Update User stock"

    assert_text "User stock was successfully updated"
    click_on "Back"
  end

  test "destroying a User stock" do
    visit user_stocks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User stock was successfully destroyed"
  end
end
