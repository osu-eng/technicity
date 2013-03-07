class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.integer :user_id
      t.string :slug
      t.string :name
      t.boolean :public

      t.timestamps
    end
  end
end
