class AddTimeWorkedToSpot < ActiveRecord::Migration
  def change
    add_column :spots, :time_worked, :int
  end
end
