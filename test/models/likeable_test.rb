require 'test_helper'

class LikeableTest < ActiveSupport::TestCase
  
  def setup
    @likeable = Likeable.new(liker_id: users(:matt).id, liked_id: users(:jess).id)
  end
  
  test "should be valid" do
    assert @likeable.valid?
  end
  
end
  
