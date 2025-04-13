# spec/request/login_spec.rb
require 'rails_helper'

RSpec.describe "Login Page", type: :request do
  let!(:user) { create(:user, email: "test@example.com", password: "password123") }

  describe "POST /users/sign_in" do
    context "with valid credentials" do
      it "logs in and redirects to root or rooms page" do
        post user_session_path, params: {
          user: {
            email: "test@example.com",
            password: "password123"
          }
        }

        expect(response).to redirect_to(root_path).or redirect_to(rooms_path)
        follow_redirect!
        expect(response.body).to include("RoomEase")
      end
    end

    context "with invalid credentials" do
      it "re-renders login page with error message" do
        post user_session_path, params: {
          user: {
            email: "test@example.com",
            password: "wrongpassword"
          }
        }

        expect(response).to have_http_status(422)
        expect(response.body).to include("Invalid Email or password")
      end
    end
  end

  describe "GET /users/sign_in" do
    it "renders the login form correctly" do
      get new_user_session_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Log in")
      expect(response.body).to include("email")
      expect(response.body).to include("password")
    end
  end
end
