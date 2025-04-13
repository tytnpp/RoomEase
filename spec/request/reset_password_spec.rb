require 'rails_helper'

RSpec.describe "Forgot Password Page", type: :request do
  describe "POST /users/password" do
    let!(:user) { create(:user, email: "testuser@example.com") }

    context "with valid email" do
      it "sends reset password instructions and redirects with notice" do
        post user_password_path, params: {
          user: { email: user.email }
        }

        expect(response).to redirect_to("/users/sign_in")
        follow_redirect!
        expect_flash_notice("You will receive an email with instructions on how to reset your password in a few minutes.")
      end
    end

    context "with invalid email" do
      it "renders the page with error message" do
        post user_password_path, params: {
          user: { email: "notfound@example.com" }
        }

        expect(response).to render_template(:new)
        expect(response.body).to include("Email not found")
      end
    end
  end

  def expect_flash_notice(message)
    expect(flash[:notice]).to eq(message)
  end
end
