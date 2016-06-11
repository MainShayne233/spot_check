class RenameSortIndexToRowOrderOnActivities < ActiveRecord::Migration
  def change
    rename_column :activities, :sort_index, :row_order
  end
end
