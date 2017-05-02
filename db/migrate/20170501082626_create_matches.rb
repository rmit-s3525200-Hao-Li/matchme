class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :user_one_id
      t.integer :user_two_id

      t.timestamps
    end
    add_index :matches, :user_one_id
    add_index :matches, :user_two_id
    add_index :matches, [:user_one_id, :user_two_id], unique: true
  end
end
