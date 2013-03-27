class RemoveIntegerFromStudy < ActiveRecord::Migration
  def up
    remove_column :studies, :integer
  end

  def down
  end
end
