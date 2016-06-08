class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :user_id
      t.boolean :show_all_spots, default: true

      t.timestamps null: false
    end
  end
end
