class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  require 'will_paginate/array'
  
  private
    
    # Confirms a logged in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to signin_url
      end
    end
    
    # Confirms a logged out user
    def not_logged_in
      unless !logged_in?
        redirect_to root_url
      end
    end
    
end
