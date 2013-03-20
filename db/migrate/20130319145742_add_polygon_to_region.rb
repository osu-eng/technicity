class AddPolygonToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :polygon, :text
  end
end
