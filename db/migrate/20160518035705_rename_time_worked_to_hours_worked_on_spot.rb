class RenameTimeWorkedToHoursWorkedOnSpot < ActiveRecord::Migration
  def change
    rename_column :spots, :time_worked, :hours_worked
  end
end
