class AddDefaultValueToHoursLeftOnActivities < ActiveRecord::Migration
  def change
    change_column :activities, :hours_left, :int, default: 0
  end
end
