module LoginSupport
  def valid_login(user)
    visit root_path
    click_link "login"
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "login"
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
