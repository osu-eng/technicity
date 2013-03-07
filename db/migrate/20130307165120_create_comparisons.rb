class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
      t.integer :chosen_location_id
      t.integer :rejected_location_id
      t.string :remote_ip

      t.timestamps
    end
  end
end
