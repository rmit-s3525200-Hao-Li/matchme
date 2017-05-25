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
end
