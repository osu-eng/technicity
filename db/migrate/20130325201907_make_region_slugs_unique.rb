class MakeRegionSlugsUnique < ActiveRecord::Migration
  def up
    add_index :regions, :slug, :unique => true
  end

  def down
  end
end
