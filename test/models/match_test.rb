require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  
  def setup
    @match = Match.new(user_one_id: users(:matt).id, user_two_id: users(:jess).id)
  end
  
  test "should be valid" do
    assert @match.valid?
  end
  
  test "user_one_id should be present" do
    @match.user_one_id = nil
    assert_not @match.valid?
  end
    test "user_two_id should be present" do
    @match.user_two_id = nil
    assert_not @match.valid?
  end

end
