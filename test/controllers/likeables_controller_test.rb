require 'test_helper'

class LikeablesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:matt)
  end
  
  test "create should require logged-in user" do
    assert_no_difference 'Likeable.count' do
      post likeables_path
    end
    assert_redirected_to signin_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Likeable.count' do
      delete likeable_path(likeables(:one))
    end
    assert_redirected_to signin_url
  end
  
  test "user cannot like themselves" do
    log_in_as(@user)
    assert_no_difference 'Likeable.count' do
      post likeables_path, params: { liker_id: @user.id, liked_id: @user.id }
    end
    assert_redirected_to @user
  end
  
end
