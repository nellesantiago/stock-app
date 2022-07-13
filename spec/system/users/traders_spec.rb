require 'rails_helper'

RSpec.describe "Users", type: :system do
  fixtures :all
  before do
    driven_by(:rack_test)
    @admin = users(:admin)
    @trader = users(:trader)
    @unconfirmed_trader = users(:unconfirmed_trader)
    visit new_user_session_path
  end

  # trader user story #1 and #3
  it "allows user to create an account" do
    visit new_user_registration_path

    fill_in "First Name", with: "System"
    fill_in "Last Name", with: "Test"
    fill_in "Email", with: "systemtest@gmail.com"
    fill_in "Password (6 characters minimum)", with: "1234567890"
    fill_in "Confirm Password", with: "1234567890"

    click_button "Sign up"

    expect(page).to have_text("A message with a confirmation link has been sent to your email address.")
  end

  # trader user story #2
  it "allows user to sign in as a trader" do
    sign_in @trader

    visit dashboard_path
    expect(page).to have_text("Welcome, Maia!")
  end

  it "allows user to sign in as an admin" do
    sign_in @admin

    visit users_path
    expect(page).to have_text("All Traders")
  end

  it "allows user to reset password" do
    visit new_user_password_path
    fill_in "Email", with: @trader.email

    click_button "Send me reset password instructions"

    expect(page).to have_text("You will receive an email with instructions on how to reset your password in a few minutes.")
  end

  it "allows user to resend confirmation instructions" do
    visit new_user_confirmation_path
    fill_in "Email", with: @unconfirmed_trader.email

    click_button "Resend confirmation instructions"

    expect(page).to have_text("You will receive an email with instructions for how to confirm your email address in a few minutes.")
  end

  it "doesn't allow unregistered account to sign in" do
    visit new_user_session_path
    fill_in "Email", with: "unregistered@gmail.com"
    fill_in "Password", with: "1234567890"

    click_button "Log in"

    expect(page).to have_text("Invalid Email or password.")
  end

end
