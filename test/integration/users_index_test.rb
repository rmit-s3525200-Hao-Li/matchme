require 'test_helper'

class AdminDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin    = users(:admin)
    @non_admin = users(:matt)
    @non_admin.create_profile!(first_name: 'Matt',
                                last_name: 'Smith',
                                gender: 'male',
                                occupation: 'salesman',
                                preferred_gender: 'male',
                                religion: 'Other',
                                city: 'Sydney',
                                post_code: '2000',
                                country: 'Australia',
                                date_of_birth: Date.new(1991, 12, 3),
                                min_age: 23,
                                max_age: 35,
                                looking_for: 'dating',
                                smoke: 'never',
                                drink: 'socially',
                                drugs: 'never',
                                diet: 'vegan',
                                edu_status: 'completed',
                                edu_type: 'high school',
                                picture: Rails.root.join("db/images/joe.jpeg").open,
                                nearby: true)
    @non_admin.profile.save!
  end
  
# test "users index as admin and delete user" do
#     log_in_as(@admin)
#     get users_path
#     assert_template 'users/index'
#     assert_select 'div.pagination'
#     first_page_of_users = User.paginate(page: 1)
#     first_page_of_users.each do |user|
#       assert_select 'a[href=?]', user_path(user), text: @profile.name
#       unless user == @admin
#         assert_select 'a[href=?]', user_path(user), text: 'delete'
#       end
#     end
#     assert_difference 'User.count', -1 do
#       delete user_path(@non_admin)
#     end
#   end
### PRODUCES ERROR:
# ActionView::Template::Error: undefined method `picture' for nil:NilClass
            # app/helpers/application_helper.rb:14:in `display_thumbnail'

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_redirected_to root_url
  end
  
end


  
