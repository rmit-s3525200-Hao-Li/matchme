class ChangeMusicToText < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :music, :text
  end
end
