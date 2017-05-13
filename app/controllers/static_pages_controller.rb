class StaticPagesController < ApplicationController
  
  before_action :redirect_logged_in_user
  
  def home
    @user = User.new
  end
  
  private
  
    def redirect_logged_in_user
      if logged_in?
        redirect_to matches_user_path(current_user)
      end
    end
end
