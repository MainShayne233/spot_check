class AddWorkAccmplishedToSpot < ActiveRecord::Migration
  def change
    add_column :spots, :work_accomplished, :text
  end
end
