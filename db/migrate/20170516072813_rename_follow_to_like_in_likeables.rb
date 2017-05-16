class RenameFollowToLikeInLikeables < ActiveRecord::Migration[5.0]
  def change
    rename_column :likeables, :follower_id, :liker_id
    rename_column :likeables, :followed_id, :liked_id
  end
end
