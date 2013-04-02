class AddZoomCenterToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :zoom, :integer
    add_column :regions, :center, :string
  end
end
