class RenameSortIndexToRowOrderForSpots < ActiveRecord::Migration
  def change
    rename_column :spots, :sort_index, :row_order
  end
end
