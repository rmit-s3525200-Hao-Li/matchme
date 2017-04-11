require 'test_helper'

class AdminDeleteTest < ActionDispatch::IntegrationTest
  def setup
  
    @non_admin = users(:matt)
  end


  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
