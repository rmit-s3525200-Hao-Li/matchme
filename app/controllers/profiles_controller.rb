class ProfilesController < ApplicationController
  
   before_action :logged_in_user, only: [:create, :update]
  
  def create
    @profile = current_user.create_profile(profile_params)
    if @profile.save
      flash[:success] = "Profile created!"
      redirect_to root_url
    else
      render 'users/new'
    end
  end
  
  # Patch method for updating profile
  def update
    @user = User.find(params[:id])
    @profile = @user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :gender, :date_of_birth, :occupation, :religion, :smoke, :drink, :education, :self_summary, :movies, :tv_shows, :books, :games, :sports, :picture, :city, :post_code, :country, :looking_for, :preferred_gender, :nearby, :min_age, :max_age)
    end
  
end
