class AddSortIndexToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :sort_index, :integer
  end
end
