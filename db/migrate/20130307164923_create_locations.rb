class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :region_id
      t.float :lattitude
      t.float :longitude
      t.integer :heading
      t.integer :pitch

      t.timestamps
    end
  end
end
