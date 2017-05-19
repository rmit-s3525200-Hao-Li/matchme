require 'test_helper'

class LikeableTest < ActiveSupport::TestCase
  def setup
    @like_id =likeables(:one)
    
  end
  
  test "should be valid" do
    assert @like_id.valid?

  end
end
