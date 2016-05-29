class RemoveHoursLeftFromSpots < ActiveRecord::Migration
  def change
    remove_column :spots, :hours_left
  end
end
