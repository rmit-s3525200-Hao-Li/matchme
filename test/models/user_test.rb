require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:matt)
    @other_user = users(:jess)
  end
    
  test "should be valid" do
    assert @user.valid?
  end
  
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "MatT@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid email addresses" do
    valid_addresses = %w[foobar@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "password should have numbers and letters" do
    @user.password = @user.password_confirmation = "a" * 6
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end
  
  test "associated profile should be destroyed" do 
    @user.save
    @user.create_profile!(first_name: 'Matt',
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
                                nearby: true)
    assert_difference 'Profile.count', -1 do
      @user.destroy
    end
  end
  
  test "associated likes should be destroyed" do
    @user.save
    @user.like(@other_user)
    assert_difference 'Likeable.count', -1 do
      @user.destroy
    end
  end
  
  test "associated match users plus matches should be destroyed" do
    @user.save
    @other_user.save
    @user.create_profile!(first_name: 'Matt',
                                last_name: 'Smith',
                                gender: 'male',
                                occupation: 'salesman',
                                preferred_gender: 'female',
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
                                nearby: true)
    @other_user.create_profile!(first_name: 'Jess',
                                last_name: 'Sagan',
                                gender: 'female',
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
                                nearby: true)
    assert @user.match_users.any?
    assert_difference 'Match.count', -1 do
      @user.destroy
    end
  end
  
end