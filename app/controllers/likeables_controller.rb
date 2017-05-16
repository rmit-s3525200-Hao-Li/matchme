class LikeablesController < ApplicationController
  before_action :logged_in_user
  before_action :is_other_user, only: :create

  def create
    user = User.find(params[:liked_id])
    current_user.like(user)
    redirect_to user
  end

  def destroy
    user = Likeable.find(params[:id]).liked
    current_user.unlike(user)
    redirect_to user
  end
  
  private
    
    # Ensures users cannot like themselves
    def is_other_user
      user = User.find(params[:liked_id])
      if current_user?(user)
        flash[:danger] = "You cannot like yourself"
        redirect_to(user)
      end
    end
  
end
