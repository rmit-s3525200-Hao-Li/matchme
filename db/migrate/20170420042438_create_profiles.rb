class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :occupation
      t.string :religion
      t.date :date_of_birth
      t.string :picture
      t.string :smoke
      t.string :drink
      t.text :self_summary
      t.string :city
      t.string :post_code
      t.string :country
      t.float :latitude
      t.float :longitude
      t.string :looking_for
      t.string :preferred_gender
      t.integer :min_age
      t.integer :max_age
      t.text :movies, array: true, default: []
      t.text :tv_shows, array: true, default: []
      t.text :books, array: true, default: []
      t.text :games, array: true, default: []
      t.text :sports, array: true, default: []
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
