class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :date_of_birth
      t.string :gender
      t.string :orientation
      t.string :occupation
      t.string :religion
      t.string :city
      t.string :post_code
      t.string :country
      t.text :self_summaryrail
      t.string :preferred_gender
      t.integer :min_age
      t.integer :max_age
      t.string :image_url

      t.timestamps
    end
  end
end
