require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user       = users(:matt)
    @other_user = users(:jess)
    @admin      = users(:admin)
  end
  
  test "should not get new if logged in" do
    log_in_as(@user)
    get users_path
    assert_redirected_to root_url
  end
  
  test "should get edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end
  
  test "should not get wrong user for edit" do
    log_in_as(@user)
    get edit_user_path(@other_user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect likeables when not logged in" do
   assert_no_difference 'Likeable.count' do
      post likeables_path
    end
    assert_not flash.empty?
    assert_redirected_to signin_url
  end
  
  test "should redirect show profile if not logged in" do
    get users_path(@user)
    assert_not flash.empty?
    assert_redirected_to signin_url
  end
  
  test "should get matches" do
    log_in_as(@user)
    get matches_user_path(@user)
    assert_response :success
  end
  
  test "should redirect matches if not logged in" do
    get matches_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to signin_url
  end
  
  test "should redirect matches if wrong user" do
    log_in_as(@other_user)
    get matches_user_path(@user)
    assert_redirected_to root_url
  end
  
  test "should redirect matches if admin" do
    log_in_as(@admin)
    get matches_user_path(@user)
    assert_redirected_to root_url
  end
  
  test "should get users index if admin" do
    log_in_as(@admin)
    get users_path
    assert_response :success
  end
  
  test "shouldn't get users index if not admin" do
    log_in_as(@user)
    get users_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "shouldn't get users index if not logged in" do
    get users_path
    assert_not flash.empty?
    assert_redirected_to signin_url
  end
  
  test "should redirect users index if not logged in" do
    get users_path
    assert_not flash.empty?
    assert_redirected_to signin_url
  end
  
  test "should redirect edit action when not logged in" do
    patch user_path(@user), params: { user: { email: "foo@bar.com" } }
    assert_not flash.empty?
    assert_redirected_to signin_url
  end
  
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:              "password1",
                                            password_confirmation: "password1",
                                            admin: true } }
    assert_not @other_user.reload.admin?
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_not flash.empty?
    assert_redirected_to signin_url
  end
  
  test "should redirect destroy when not admin" do
    log_in_as(@user)
    assert_not @user.admin?
    assert_no_difference 'User.count' do
      delete user_path(@other_user)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
end
