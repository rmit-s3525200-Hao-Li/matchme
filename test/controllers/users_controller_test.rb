require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user       = users(:matt)
    @other_user = users(:xieyang)
  end
  
  test "should not get new if logged in" do
    log_in_as(@user)
    get users_path
    assert_redirected_to root_url
  end
  
  test "should get edit" do
    log_in_as(@user)
    get edit_user_profiles_path(@user)
    assert_response :success
  end
  
  test "should not get wrong user for edit" do
    log_in_as(@user)
    get edit_user_profiles_path(@other_user)
    assert_redirected_to root_url
  end
end
