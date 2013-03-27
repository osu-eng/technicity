class ChangeStudyUserToInt < ActiveRecord::Migration
  def up
    remove_column :studies, :user_id
    add_column :studies, :user_id, :integer
  end

  def down
  end
end
