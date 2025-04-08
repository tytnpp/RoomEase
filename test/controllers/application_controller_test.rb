require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "after sign out should redirect to login page" do
    delete destroy_user_session_path
    assert_redirected_to new_user_session_path
  end
end
