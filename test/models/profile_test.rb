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
    @profile.last_name = "     "
    assert_not @profile.valid?
  end
  
  test "last_name shouldn't be more than 25 characters" do
    @profile.first_name = "a" * 26 
    assert_not @profile.valid?
  end
  
  test "occupation should be present" do
     @profile.occupation = "     "
    assert_not @profile.valid?
  end
  
  test "occupation shouldn't be too long" do
     @profile.occupation = "a"*51
    assert_not @profile.valid?
  end
  
  test "occupation should be saved in lower-case" do
   
  end
  
  test "name should be a titleized string of first_name and last_name" do
    @profile.first_name = "xieyang"
    @profile.last_name = "wu"
    @profile.save
    assert_equal "Xieyang Wu", @profile.reload.name
  end
  
end
