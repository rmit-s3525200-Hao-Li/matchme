class RenameRelationship < ActiveRecord::Migration[5.0]
  def change
    rename_table :relationships, :likeables
  end
end
