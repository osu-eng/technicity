class RemoveStudySti < ActiveRecord::Migration
  def up
    remove_column :studies, :type
  end

  def down
  end
end
