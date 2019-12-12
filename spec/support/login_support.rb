module LoginSupport
  def valid_login(user)
    visit root_path
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "login"
  end
end
