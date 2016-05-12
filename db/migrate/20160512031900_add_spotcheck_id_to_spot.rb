class AddSpotcheckIdToSpot < ActiveRecord::Migration
  def change
    add_column :spots, :spotcheck_id, :int
  end
end
