class CreateSpotchecks < ActiveRecord::Migration
  def change
    create_table :spotchecks do |t|

      t.timestamps null: false
    end
  end
end
