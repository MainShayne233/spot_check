class AddActivityIdToSpot < ActiveRecord::Migration
  def change
    add_column :spots, :activity_id, :int
  end
end
