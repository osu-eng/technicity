class FixCenterRegion < ActiveRecord::Migration
  def up
    remove_column :regions, :center
    add_column :regions, :latitude, :string
    add_column :regions, :longitude, :string
  end

  def down
  end
end
