class AddHoursLeftToSpot < ActiveRecord::Migration
  def change
    add_column :spots, :hours_left, :int
  end
end
