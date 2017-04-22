class ChangeDefaultForOtherInterests < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :tv_shows, :text, :default => nil
    change_column :profiles, :books, :text, :default => nil
    change_column :profiles, :games, :text, :default => nil
    change_column :profiles, :sports, :text, :default => nil
  end
end
