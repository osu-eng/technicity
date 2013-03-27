class MakeStudySlugsUnique < ActiveRecord::Migration
  def up
    add_index :studies, :slug, :unique => true
  end

  def down
  end
end
