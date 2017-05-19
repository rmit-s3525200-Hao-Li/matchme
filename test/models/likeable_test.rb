require 'test_helper'

class LikeableTest < ActiveSupport::TestCase
  def setup
    @likeable = Likeable.new(liker_id: users(:matt).id, liked_id: users(:jess).id)
  end
  
  test "should be valid" do
    assert @likeable.valid?
  end
  
  test "liker_id should be present" do
    @likeable.liker_id = nil
    assert_not @likeable.valid?
  end
  test "liked_id should be present" do
    @likeable.liked_id = nil
    assert_not @likeable.valid?
  end
end
  
