class AddSortIndexToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :sort_index, :integer
  end
end
