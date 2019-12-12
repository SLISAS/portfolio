require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe "User" do
    it "should be valid" do
      expect(user).to be_valid
    end
  end

  describe "name" do
    it "gives presence" do
      user.name = ""
      expect(user).to be_invalid
    end
  end

  context "when 50 characters" do
    it "is not too long" do
      user.name = "a" * 51
      expect(user).to be_invalid
    end
  end

  describe "email" do
    it "gives presence" do
      user.email = ""
      expect(user).to be_invalid
    end

    context "when 254 char" do
      it "is acceptable" do
        user.email = "a" * 243 + "@example.com"
        expect(user).to be_valid
      end
    end

    context "when 255 char" do
      it "is too long" do
        user.email = "a" * 244 + "@example.com"
        expect(user).to be_invalid
      end
    end

    it "should be accepted valid addresses" do
      user.email = "user@example.com"
      expect(user).to be_valid

      user.email = "User@foobar.com"
      expect(user).to be_valid

      user.email = "U.u_seeR@foo.jp"
      expect(user).to be_valid
    end

    context "when mixed lower-case and upper-case" do
      it "should be saved as lower-case" do
        user.email = "Foo@example.OrG"
        user.save!
        expect(user.reload.email).to eq "foo@example.org"
      end
    end
  end

  describe "password validates" do
    context "when password is invalid" do
      it "should be present (nonblank)" do
        user.password = user.password_confirmation = "" * 6
        expect(user).to be_invalid
      end

      it "is too short (within 6 chars)" do
        user.password_confirmation = user.password_confirmation = "a" * 5
        expect(user).to be_invalid
      end
    end

    context "when password is valid" do
      it "is acceptable (more than 6 chars)" do
        user.password = user.password_confirmation = "a" * 6
        expect(user).to be_valid
      end
    end
  end

  describe "GET #show" do
    context "when login as authenticated user" do
      it "responds successfully" do
        log_in_as user
        get user_path(user)
        expect(response).to be_success
        expect(response).to have_http_status "200"
      end
    end

    context "when as a guest" do
      it "redirects to login page" do
        get user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    context "as other user" do
      before do
        @other_user = FactoryBot.create(:user)
      end

      it "redirects to the login page" do
        log_in_as @other_user
        get user_path(user)
        expect(response).to redirext_to root_path
      end
    end
  end
end
