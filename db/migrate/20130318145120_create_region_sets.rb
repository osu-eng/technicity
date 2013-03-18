class CreateRegionSets < ActiveRecord::Migration
  def change
    create_table :region_sets do |t|
      t.integer :user_id
      t.string :slug
      t.string :name
      t.boolean :public

      t.timestamps
    end
  end
end
