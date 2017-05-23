class ProfilesController < ApplicationController
  
  # User cannot edit or create profiles on behalf of other users
  before_action :correct_user
  
  # Find user in database
  before_action :get_user
  
  # Admin doesn't have a profile
  before_action :non_admin_user, only: [:new, :create, :edit, :update]
  
  # User that already has a profile doesn't need another one
  before_action :has_no_profile, only: [:new, :create]
  
  def new
    @profile = @user.build_profile
  end
  
  def create
    @profile = current_user.create_profile(profile_params)
    if @profile.save
      flash[:success] = "Welcome to MatchMe!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @profile = @user.profile
  end
  
  # Patch method for updating profile
  def update
    @profile = @user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
    # Finds user
    def get_user
      @user = User.find(params[:user_id])
    end
  
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :gender, :date_of_birth, :occupation, :religion, :smoke, :drink, :drugs, :diet, :education, :self_summary, :hobbies, :movies, :tv_shows, :music, :books, :games, :sports, :picture, :city, :post_code, :country, :looking_for, :preferred_gender, :nearby, :min_age, :max_age, :edu_status, :edu_type)
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:user_id])
      unless current_user?(@user)
        flash[:danger] = "You are not authorized to view that page"
        redirect_to(root_url)
      end
    end
    
    # Confirms non admin user.
    def non_admin_user
      @user = User.find(params[:user_id])
      unless !@user.admin?
        flash[:danger] = "You cannot access that page"
        redirect_to(root_url)
      end
    end
    
    # Checks whether or not a user already has a profile
    def has_no_profile
      @user = User.find(params[:user_id])
      unless @user.profile.nil?
        flash[:danger] = "You already have a profile!"
        redirect_to(@user)
      end
    end
  
end
