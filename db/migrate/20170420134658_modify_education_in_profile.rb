class ModifyEducationInProfile < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :education
    add_column :profiles, :edu_status, :string
    add_column :profiles, :edu_type, :string
  end
end
