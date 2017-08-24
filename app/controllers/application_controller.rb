class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user,
                :current_user_name

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user_name
    User.find(current_user.id).screen_name
  end
end
