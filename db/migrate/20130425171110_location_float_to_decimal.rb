class LocationFloatToDecimal < ActiveRecord::Migration
  def up
    # Replace regions.latitude
    add_column :regions, :newlat, :decimal, :precision => 15, :scale => 12
    execute "UPDATE regions SET newlat = latitude"
    remove_column :regions, :latitude
    rename_column :regions, :newlat, :latitude

    # Replace regions.longitude
    add_column :regions, :newlng, :decimal, :precision => 15, :scale => 12
    execute "UPDATE regions SET newlng = longitude"
    remove_column :regions, :longitude
    rename_column :regions, :newlng, :longitude

    # Replace locations.latitude
    add_column :locations, :newlat, :decimal, :precision => 15, :scale => 12
    execute "UPDATE locations SET newlat = latitude"
    remove_column :locations, :latitude
    rename_column :locations, :newlat, :latitude

    # Replace locations.longitude
    add_column :locations, :newlng, :decimal, :precision => 15, :scale => 12
    execute "UPDATE locations SET newlng = longitude"
    remove_column :locations, :longitude
    rename_column :locations, :newlng, :longitude
  end

  def down
  end
end
