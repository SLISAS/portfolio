require "rails_helper"

RSpec.feature "Logins", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario "user successfully login" do
    valid_login(user)

    expect(current_path).to eq user_path(user)
    expect(page).to_not have_content "Login"

    click_link "Logout"

    expect(current_path).to eq root_path
    expect(page).to have_content "Login"
  end

  scenario "user doesnt login with invalid information" do
    visit root_path
    click_link "login"
    fill_in "email", with: ""
    fill_in "password", with: ""
    click_button "login"

    expect(current_path).to eq login_path
    expect(page).to have_content "Login"
    expect(page).to have_content "Invalid combination"
  end
end
