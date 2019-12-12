require "rails_helper"

RSpec.describe "PasswordResets", type: :request do
  let(:user) { FactoryBot.create(:user) }

  include ActiveJob::TestHelper

  it "resets password" do
    perform_enqueued_jobs do
      post password_resets_path, params: { password_reset: { email: "" } }
      expect(response).to render_template(:new)
      post password_resets_path, params: { password_reset: { email: user.email } }
      expect(response).to redirect_to root_path

      user = assigns(:user)

      get edit_password_reset_path(user.reset_token, email: "")
      expect(response).to redirect_to root_path
      get edit_password_reset_path("wrong_token", email: user.email)
      expect(response).to redirect_to root_path
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(response).to render_template(:edit)

      patch password_reset_path(user.reset_token),
            params: { email: user.email,
                      user: { password: "foofoo",
                              password_confirmation: "foofoo" } }
      expect(session[:user_id]).to eq user.id
      expect(response).to redirect_to user_path(user)
    end
  end
end
