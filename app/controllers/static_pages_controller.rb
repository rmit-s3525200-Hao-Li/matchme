class StaticPagesController < ApplicationController
  
  before_action :redirect_logged_in_user, only: :home
  
  def home
  end
  
  def terms
  end
  
  def faq
  end
  
  def support
  end
  
  def privacy
  end
  
  def show
    @singlepage = Singlepage.new
    render template: "static_pages/#{params[:page]}"
    
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
