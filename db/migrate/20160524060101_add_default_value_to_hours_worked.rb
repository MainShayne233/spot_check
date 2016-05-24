class AddDefaultValueToHoursWorked < ActiveRecord::Migration
  def change
    change_column :spots, :hours_worked, :int, default: 0
    change_column :spots, :hours_left, :int, default: 0
  end
end
