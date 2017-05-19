require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  
  def setup
    @match = Match.new(user_one_id: users(:matt).id, user_two_id: users(:jess).id)
  end
  
  test "should be valid" do
    assert @match.valid?
  end

end
