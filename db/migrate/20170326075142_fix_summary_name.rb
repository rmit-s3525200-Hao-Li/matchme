class FixSummaryName < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :self_summaryrail, :self_summary
  end
end
