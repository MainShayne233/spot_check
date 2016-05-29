class AddHoursLeftToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :hours_left, :int
  end
end
