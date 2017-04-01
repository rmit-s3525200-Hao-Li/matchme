class UsersController < ApplicationController
  
  # Checks that user is logged before they can access edit profile page
  # and users index page
  before_action :logged_in_user, only: [:index, :edit, :update]
  
  # Ensures users cannot access 'Edit Profile' page of other users
  before_action :correct_user,   only: [:edit, :update]
  
  # Corresponds to view/users/index.html.erb
  def index
    @users = User.all
  end
  
  # Corresponds to view/users/show.html.erb
  # User profile page
  def show
    @user = User.find(params[:id])
  end
  
  # Corresponds to view/users/new.html.erb
  # User signup page
  def new
    @user = User.new
  end
  
  # Post method for creating a user
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to MatchMe!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  # Corresponds to view/users/edit.html.erb
  # Edit profile page
  def edit
    @user = User.find(params[:id])
  end
  
  # Patch method for updating profile
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :gender, :orientation, :occupation, :religion, :city, :post_code, :country, :preferred_gender, :min_age, :max_age, :looking_for, :date_of_birth, :email, :password, :password_confirmation)
    end
    
    ### Before filters

    # Confirms user is logged in
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
