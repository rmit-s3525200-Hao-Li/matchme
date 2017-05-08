class AddDefaultValueToPercent < ActiveRecord::Migration[5.0]
  def change
    change_column :matches, :percent, :integer, :default => 0
  end
end
