class SessionsController < ApplicationController

  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to profile_index_path
    else
      render 404
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logged out successfully'
    redirect_to root_path
  end
end
