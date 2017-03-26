require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { first_name: "Natalie", last_name: "Klein", email: "klien@example.com", gender: "woman", orientation: "straight", occupation: "student", religion: "agnostic", city: "Melbourne", post_code: "3000", country: "Australia", self_summary: "Blah blah whatever whatever", preferred_gender: "A man", min_age: 20, max_age: 28, date_of_birth: Date.new(1994,5,7), password: "foobar1", password_confirmation: "foobar1" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end

end
