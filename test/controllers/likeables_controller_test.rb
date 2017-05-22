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
  
end
