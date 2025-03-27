class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Redirect user to login page after logout
  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
