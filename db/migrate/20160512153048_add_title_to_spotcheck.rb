class AddTitleToSpotcheck < ActiveRecord::Migration
  def change
    add_column :spotchecks, :title, :string
  end
end
