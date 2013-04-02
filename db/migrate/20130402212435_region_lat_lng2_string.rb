class RegionLatLng2String < ActiveRecord::Migration
  def up
    remove_column :regions, :latitude
    remove_column :regions, :longitude
    add_column :regions, :latitude, :float
    add_column :regions, :longitude, :float
  end

  def down
  end
end
