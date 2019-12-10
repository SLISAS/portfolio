require "rails_helper"

RSpec.describe "UsersSignups", type: :request do
  describe "GET /users_signups" do
    it "is invalid signup information" do
      get signup_path
      expect {
        post signup_path, params: {
                            user: {
                              name: "",
                              email: "user@invalid",
                              password: "foo",
                              password_confirmation: "bar",

                            },
                          }
      }.not_to change(User, :count)
    end

    it "is valid signup information" do
      get signup_path
      expect {
        post signup_path, params: {
                            user: {
                              name: "Example User",
                              email: "user@example.com",
                              password: "password",
                              password_confirmation: "bar",
                            },
                          }
      }.to change(User, :count).by(1)
    end
  end
end
