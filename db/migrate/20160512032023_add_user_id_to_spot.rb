class AddUserIdToSpot < ActiveRecord::Migration
  def change
    add_column :spots, :user_id, :int
  end
end
