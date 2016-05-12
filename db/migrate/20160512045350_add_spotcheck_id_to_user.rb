class AddSpotcheckIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :spotcheck_id, :int
  end
end
