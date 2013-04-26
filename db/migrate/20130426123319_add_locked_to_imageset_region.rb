class AddLockedToImagesetRegion < ActiveRecord::Migration
  def change
    add_column :region_sets, :locked, :boolean
    add_column :regions, :locked, :boolean
  end
end
