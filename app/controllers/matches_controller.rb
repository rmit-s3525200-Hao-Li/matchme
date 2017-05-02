class MatchesController < ApplicationController
  
  # Checks that user is logged in
  before_action :logged_in_user, only: [:index, :new, :create, :update, :destroy]
  
  def index
    @matches = Match.will_paginate(page: params[:page])
    # @matches.each do |m|
    #   if m.user_one_id == current_user.id || m.user_two_id == current_user.id
      
    # end
  end
  
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
