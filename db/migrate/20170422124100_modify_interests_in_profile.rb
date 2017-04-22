class ModifyInterestsInProfile < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :movies, :text
    change_column :profiles, :tv_shows, :text
    change_column :profiles, :books, :text
    change_column :profiles, :games, :text
    change_column :profiles, :sports, :text
  end
end
