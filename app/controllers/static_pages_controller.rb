class StaticPagesController < ApplicationController
  
  before_action :redirect_logged_in_user, only: :home
  
  def home
    @user = User.new
  end
  
  private
  
    def redirect_logged_in_user
      if logged_in?
        if current_user.admin?
          redirect_to users_path
        else
          redirect_to matches_user_path(current_user)
        end
      end
    end
    
end
