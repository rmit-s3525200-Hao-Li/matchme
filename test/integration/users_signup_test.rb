require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name: "", last_name: "Klein", email: "natalieklien@example", gender: "female", occupation: "student", religion: "agnostic", city: "", post_code: "3000", country: "Australia", self_summary: "Blah blah whatever whatever", preferred_gender: "male", min_age: 20, max_age: 28, looking_for: "", date_of_birth: Date.new(1994,5,7), password: "foo", password_confirmation: "foobar1" } }
    end
    assert_template 'users/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { first_name: "Natalie", last_name: "Klein", email: "natalieklien@example.com", gender: "female", occupation: "student", religion: "agnostic", city: "Melbourne", post_code: "3000", country: "Australia", self_summary: "Blah blah whatever whatever", preferred_gender: "male", min_age: 20, max_age: 28, looking_for: "long-term dating", date_of_birth: Date.new(1994,5,7), password: "foobar1", password_confirmation: "foobar1" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
  
  test "user must be at least 18" do
    now = Time.now.utc.to_date
    too_young = Date.new(now.year-18,now.month,now.day+1)
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name: "Natalie", last_name: "Klein", email: "natalieklien@example.com", gender: "female", occupation: "student", religion: "agnostic", city: "Melbourne", post_code: "3000", country: "Australia", self_summary: "Blah blah whatever whatever", preferred_gender: "male", min_age: 20, max_age: 28, looking_for: "long-term dating", date_of_birth: too_young, password: "foobar1", password_confirmation: "foobar1" } }
    end
    assert_template 'users/new'
  end

end
