class RemoveProfileFieldsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :gender
    remove_column :users, :occupation
    remove_column :users, :religion
    remove_column :users, :city
    remove_column :users, :post_code
    remove_column :users, :country
    remove_column :users, :self_summary
    remove_column :users, :preferred_gender
    remove_column :users, :min_age
    remove_column :users, :max_age
    remove_column :users, :date_of_birth
    remove_column :users, :looking_for
    remove_column :users, :latitude
    remove_column :users, :longitude
    remove_column :users, :picture
  end
end