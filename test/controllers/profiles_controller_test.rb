require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:matt)
    @other_user = users(:declan)
    @admin = users(:admin)
    @profile = profiles(:matt_profile)
  end
  
  test "should get new" do
    log_in_as(@other_user)
    get new_user_profiles_path(@other_user)
    assert_response :success
  end
  
  test "shouldn't get new if wrong user" do
    log_in_as(@user)
    get new_user_profiles_path(@other_user)
    assert_redirected_to root_url
  end
  
  test "shouldn't get new if admin" do
    log_in_as(@admin)
    get new_user_profiles_path(@admin)
    assert_redirected_to root_url
  end
  
  test "should redirect create when wrong user" do
    log_in_as(@user)
    assert_no_difference 'Profile.count' do
      post user_profiles_path(@other_user), params: { 
                              profile: {
                                first_name: 'Matt',
                                last_name: 'Smith',
                                gender: 'male',
                                occupation: 'salesman',
                                preferred_gender: 'male',
                                religion: 'other',
                                city: 'Sydney',
                                post_code: '2000',
                                country: 'Australia',
                                date_of_birth: Date.new(1991, 12, 3),
                                min_age: 23,
                                max_age: 35,
                                looking_for: 'dating',
                                smoke: 'not at all',
                                drink: 'socially',
                                drugs: 'never',
                                diet: 'vegan',
                                edu_status: 'completed',
                                edu_type: 'high school',
                                nearby: true
                              }
                            }
    end
    assert_redirected_to root_url
  end
  
  test "should redirect create when admin" do
    log_in_as(@admin)
    assert_no_difference 'Profile.count' do
      post user_profiles_path(@admin), params: { 
                              profile: {
                                first_name: 'Matt',
                                last_name: 'Smith',
                                gender: 'male',
                                occupation: 'salesman',
                                preferred_gender: 'male',
                                religion: 'other',
                                city: 'Sydney',
                                post_code: '2000',
                                country: 'Australia',
                                date_of_birth: Date.new(1991, 12, 3),
                                min_age: 23,
                                max_age: 35,
                                looking_for: 'dating',
                                smoke: 'not at all',
                                drink: 'socially',
                                drugs: 'never',
                                diet: 'vegan',
                                edu_status: 'completed',
                                edu_type: 'high school',
                                nearby: true
                              }
                            }
    end
    assert_redirected_to root_url
  end
  
  test "should get edit" do
    log_in_as(@user)
    get edit_user_profiles_path(@user)
    assert_response :success
  end
  
  test "shouldn't get edit if wrong user" do
    log_in_as(@user)
    get edit_user_profiles_path(@other_user)
    assert_redirected_to root_url
  end
  
  test "shouldn't get edit if admin" do
    log_in_as(@admin)
    get edit_user_profiles_path(@admin)
    assert_redirected_to root_url
  end
  
  test "should redirect update if wrong user" do
    log_in_as(@user)
    patch edit_user_profiles_path(@other_user)
    assert_redirected_to root_url
  end
  
  test "should redirect update if admin" do
    log_in_as(@admin)
    patch edit_user_profiles_path(@admin)
    assert_redirected_to root_url
  end

end
