class AddPercentToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :percent, :integer
  end
end
