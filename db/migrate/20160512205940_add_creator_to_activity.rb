class AddCreatorToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :creator_id, :int
  end
end
