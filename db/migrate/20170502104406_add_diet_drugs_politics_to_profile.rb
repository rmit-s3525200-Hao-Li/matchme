class AddDietDrugsPoliticsToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :diet, :string
    add_column :profiles, :drugs, :string
    add_column :profiles, :politics, :string
  end
end
