require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  def setup
    @user = users(:matt)
    @profile = profiles(:matt_profile)
  end
  
  test "should be valid" do
    assert @user.valid?
  end

  test "user id should be present" do
    @profile.user_id = nil
    assert_not @profile.valid?
  end
end
