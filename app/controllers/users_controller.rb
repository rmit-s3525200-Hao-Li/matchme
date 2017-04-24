class UsersController < ApplicationController
  
  # Checks that user is logged before they can access edit profile page
  # and users index page
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  
  # Ensures users cannot access 'Edit Profile' page of other users
  before_action :correct_user,   only: [:edit, :update]
  
  # Ensures only admin can delete users
  before_action :admin_user,     only: :destroy
  
  # Admin doesn't have a profile
  before_action :non_admin_user, only: [:show]
  
  # Corresponds to view/users/index.html.erb
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # Corresponds to view/users/show.html.erb
  # User profile page
  def show
    @user = User.find(params[:id])
    @profile = @user.profile
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
    @user = User.find(params[:id])
    @profile = @user.profile
    # @selected = user_params[:profile][:gender]
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
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private

    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation,
        profile_attributes: [:user_id, :first_name, :last_name, :gender, :date_of_birth, :occupation, :religion, :smoke, :drink, :self_summary, :movies, :tv_shows, :books, :games, :sports, :picture, :city, :post_code, :country, :looking_for, :preferred_gender, :nearby, :min_age, :max_age, :edu_status, :edu_type]
        )
    end
    
    ### Before filters
    
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

end
