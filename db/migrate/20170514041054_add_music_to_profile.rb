class AddMusicToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :music, :string
  end
end
