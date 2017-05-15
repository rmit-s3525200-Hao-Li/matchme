class MatchesController < ApplicationController
  
  # Checks that user is logged in
  before_action :logged_in_user
  
  def create
    @match = Match.new(match_params)
  end
  
  private
  
    def match_params
      params.require(:match).permit(:user_one_id, :user_two_id, :percent)
    end
end
