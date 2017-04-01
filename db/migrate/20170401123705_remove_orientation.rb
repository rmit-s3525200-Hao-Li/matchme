class RemoveOrientation < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :orientation
  end
end
