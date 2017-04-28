require 'test_helper'

class AdminDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @admin       = users(:admin)
    @non_admin = users(:matt)
  end
 test "users index as admin and delete user" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    #assert_select 'div.pagination'
    #first_page_of_users = User.paginate(page: 1)
    users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end


  
