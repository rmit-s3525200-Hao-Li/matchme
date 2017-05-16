class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :matches, :likes, :likers]
  
  # Checks that user is logged before they can access edit profile page
  # and users index page
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy, :matches]
  
  # Checks that user has created profile
  before_action :user_has_profile, only: [:show, :edit, :update, :matches]
  
  # Ensures users cannot edit others users or view their matches page
  before_action :correct_user,   only: [:edit, :update, :matches, :likes, :likers]
  
  # Ensures only admin can delete users
  before_action :admin_user,     only: [:index, :destroy]
  
  # Admin doesn't have a profile or matches
  before_action :non_admin_user, only: [:show, :matches]
  
  # Corresponds to view/users/index.html.erb
  def index
    @users = User.search(params[:search]).paginate(page: params[:page], per_page: 6)
  end
  
  # Corresponds to view/users/show.html.erb
  # User profile page
  def show
    @profile = @user.profile
    if @user != current_user
      @matches = current_user.matches
    end
  end
  
  # Corresponds to view/users/new.html.erb
  # User signup page
  def new
    @user = User.new
    @profile = @user.build_profile
  end
  
  # Post method for creating a user
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to new_user_profiles_path(@user)
    else
      render 'new'
    end
  end
  
  # Corresponds to view/users/edit.html.erb
  # Edit profile page
  def edit
    @profile = @user.profile
    # @selected = user_params[:profile][:gender]
  end
  
  # Patch method for updating profile
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Account settings updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  # Method for deleting a user
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  # Corresponds to view/users/matches.html.erb
  # User matches page
  def matches
    @matches = @user.matches
    @users = @user.match_users
    @users = @users.paginate(page: params[:page], per_page: 6)
    @show_percent = true
  end
  
  def likes
    @profile = @user.profile
    @title = "Likes"
    @users = @user.likes.paginate(page: params[:page], per_page: 6)
    @show_return = true
    render 'show_like'
  end

  def likers
    @profile = @user.profile
    @title = "Liked By"
    @users = @user.likers.paginate(page: params[:page], per_page: 6)
    @show_return = true
    render 'show_like'
  end

  
  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
    
    ### Before filters
    
    # Sets user
    def set_user
      @user = User.find(params[:id])
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms non admin user.
    def non_admin_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless !@user.admin?
    end

    #Confirms profile has been created
    def user_has_profile
      if !current_user.admin?
        @profile = current_user.profile
        redirect_to new_user_profiles_path(current_user) unless Profile.exists?(@profile)
      end
    end
    
end
