require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  def setup
    @profile = profiles(:matt_profile)
  end
  
  test "should be valid" do
    assert @profile.valid?
  end
  
  test "user id should be present" do
    @profile.user_id = nil
    assert_not @profile.valid?
  end
  
  test "first_name should be present" do
     @profile.first_name = "     "
    assert_not @profile.valid?
  end
  
  test "first_name shouldn't be more than 25 characters" do
     @profile.first_name = "a" * 26 
    assert_not @profile.valid?
  end
  
  test "last_name should be present" do
  end
  
  test "last_name shouldn't be more than 25 characters" do
  end
  
  test "occupation should be present" do
  end
  
  test "occupation shouldn't be too long" do
  end
  
  test "occupation should be saved in lower-case" do
  end
  
  
end
