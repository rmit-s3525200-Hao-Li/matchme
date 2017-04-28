require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:matt)
    @profile = profiles(:matt_profile)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
                                              last_name: "",
                                              gender: "",
                                              date_of_birth: @user.date_of_birth,
                                              occupation: "",
                                              religion: "",
                                              preferred_gender: "",
                                              min_age: @user.min_age,
                                              max_age: @user.max_age,
                                              self_summary: "",
                                              city: "",
                                              post_code: "",
                                              country: "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    first_name  = "Foo"
    last_name = "Bar"
    email = "foobar@example.com"
    dob = Date.new(1990,1,1)
    min_age = 20
    max_age = 30
    patch user_path(@user), params: { user: { first_name:  first_name,
                                              last_name: last_name,
                                              gender: @user.gender,
                                              date_of_birth: dob,
                                              occupation: @user.occupation,
                                              religion: @user.religion,
                                              preferred_gender: @user.preferred_gender,
                                              min_age: min_age,
                                              max_age: max_age,
                                              self_summary: @user.self_summary,
                                              city: @user.city,
                                              post_code: @user.post_code,
                                              country: @user.country,
                                              email: email,
                                              picture: @user.picture,
                                              looking_for: @user.looking_for,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name,  @user.first_name
    assert_equal last_name,  @user.last_name
    assert_equal email, @user.email
  end
end