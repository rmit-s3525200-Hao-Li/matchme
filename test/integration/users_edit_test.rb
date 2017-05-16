require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:matt)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    email = "foobar@example.com"
    password = "newpassord1"
    patch user_path(@user), params: { user: { 
                                              email: email,
                                              password: password,
                                              password_confirmation: password } }
    assert_not flash.empty?
    assert_redirected_to @user
  end
end