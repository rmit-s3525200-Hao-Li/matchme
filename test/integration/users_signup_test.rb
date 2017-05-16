require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { email: "natalieklien@example", password: "foo", password_confirmation: "foobar1" } }
    end
    assert_template 'users/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { email: "natalieklien@example.com", password: "foobar1", password_confirmation: "foobar1" } }
    end
    follow_redirect!
    assert is_logged_in?
  end

end
