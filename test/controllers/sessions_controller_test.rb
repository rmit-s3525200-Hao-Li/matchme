require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:matt)
    @other_user = users(:jess)
  end
  
  test "should get new" do
    get signin_path
    assert_response :success
  end
  
  test "should not get new if logged in" do
    log_in_as(@user)
    get signin_path
    assert_redirected_to root_url
  end
  
  test "should not create if logged in" do
    log_in_as(@user)
    post signin_path, params: { session: { email: @other_user.email, password: 'foobar1', remember_me: '1' } }
    assert_redirected_to root_url
  end

end
