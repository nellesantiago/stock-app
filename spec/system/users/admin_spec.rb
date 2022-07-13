require 'rails_helper'

RSpec.describe "Admins", type: :system do
  fixtures :all
  before do
    driven_by(:rack_test)
    @admin = users(:admin)
    visit new_user_session_path
    sign_in @admin
  end

  # admin user story #1
  it "allows admin to add new user" do
    visit users_path
    
    click_on "+ Add New User"

    fill_in "First Name", with: "New"
    fill_in "Last Name", with: "User"
    fill_in "Email Address", with: "newuser@email.com"
    fill_in "Password (minimum 6 characters)", with: "1234567890"
    fill_in "Confirm Password", with: "1234567890"

    click_button "Create User"

    visit users_path
    expect(page).to have_text("newuser@email.com")
  end

  # admin user story #2
  it "allows admin to edit user details" do
    Capybara.current_driver = :selenium
    visit users_path
    
    click_on(class: 'edit-pen')
    fill_in "user_first_name", with: "New Name"

    click_button "Update User"
    expect(page).to have_text("User was successfully updated.")
  end

  # admin user story #4
  it "allows admin to sign in and view all traders" do
    visit users_path

    expect(page).to have_text("All Traders")
  end

  # admin user story #5
  it "allows admin to view all pending traders" do
    visit users_path

    expect(page).to have_text("Pending")
  end

  # admin user story #6
  it "allows admin to approve a user" do
    visit users_path

    first('.approve-icon').click

    expect(page).to have_text("User was successfully updated.")
  end

  it "allows admin to decline a user" do
    visit users_path

    first('.decline-icon').click

    expect(page).to have_text("User was successfully updated.")
  end

  it "allows admin to delete a user" do
    Capybara.current_driver = :selenium
    visit users_path

    accept_confirm("Delete user?") do      
      click_link(class: 'delete-trash')
    end

    expect(page).to have_text("User was successfully deleted.")
  end
  
end
