require 'rails_helper'

RSpec.describe "Sign Up Page", type: :request do
  describe "GET /users/sign_up" do
    it "renders the sign up form" do
      get new_user_registration_path
      expect(response).to have_http_status(:ok)
      expect_to_see(response.body, "Sign up")
      expect_to_see(response.body, "Email")
      expect_to_see(response.body, "Password")
      expect_to_see(response.body, "Password confirmation")
    end
  end

  describe "POST /users" do
    context "with valid details" do
        it "creates a new user and logs them in" do
            post user_registration_path, params: {
              user: {
                email: "newuser@example.com",
                password: "password123",
                password_confirmation: "password123"
              }
            }

            expect(response).to redirect_to(root_path) # ✅ แก้เป็น root_path ตามที่ตั้งไว้
            follow_redirect!

            # ✅ ตรวจจาก flash แทน body
            expect(flash[:notice]).to eq("Welcome! You have signed up successfully.")
        end
    end

    context "with invalid details" do
      it "shows error messages" do
        post user_registration_path, params: {
          user: {
            email: "",
            password: "short",
            password_confirmation: "wrong"
          }
        }

        expect(response).to have_http_status(422)
        expect(response.body).to include("error")
      end
    end
  end

  def expect_to_see(body, content)
    expect(body).to include(content)
  end
end
