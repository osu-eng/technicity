class AddDescriptionToRegionAndRegionSet < ActiveRecord::Migration
  def change
    add_column :regions, :description, :text
    add_column :region_sets, :description, :text
  end
end
