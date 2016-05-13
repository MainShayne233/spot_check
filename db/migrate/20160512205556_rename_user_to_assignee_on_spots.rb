class RenameUserToAssigneeOnSpots < ActiveRecord::Migration
  def change
    rename_column :spots, :user_id, :assignee_id
  end
end
