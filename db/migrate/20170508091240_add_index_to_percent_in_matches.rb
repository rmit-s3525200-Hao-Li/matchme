class AddIndexToPercentInMatches < ActiveRecord::Migration[5.0]
  def change
    add_index :matches, :percent
  end
end
