class AddNearbyToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :nearby, :boolean
  end
end
