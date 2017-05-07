class MatchesController < ApplicationController
  
  # Checks that user is logged in
  before_action :logged_in_user, only: [:new, :create, :update, :destroy]
  
  def new
    @match = Match.new
  end
  
  def create
    @match = Match.new(match_params)
  end

  def update
  end

  def destroy
  end
  
  private
  
    def match_params
      params.require(:match).permit(:user_one_id, :user_two_id)
    end
end
