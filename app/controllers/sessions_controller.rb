class SessionsController < ApplicationController
  
  # Only users that are not logged in can access login page
  before_action :not_logged_in, only: [:new, :create]
  
  # Sign in page
  def new
  end
  
  # Sign in action
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      if user.admin?
        redirect_to users_url
      else
        redirect_back_or user
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  # Log out action
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end
