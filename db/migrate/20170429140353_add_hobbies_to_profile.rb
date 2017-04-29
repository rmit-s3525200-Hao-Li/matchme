class AddHobbiesToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :hobbies, :text
  end
end
