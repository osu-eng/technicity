class CorrectLatSpelling < ActiveRecord::Migration
  def up
    rename_column :locations, :lattitude, :latitude
  end

  def down
  end
end
