class RemovePoliticsFromProfile < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :politics
  end
end
