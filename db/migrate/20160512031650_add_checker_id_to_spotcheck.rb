class AddCheckerIdToSpotcheck < ActiveRecord::Migration
  def change
    add_column :spotchecks, :checker_id, :int
  end
end
