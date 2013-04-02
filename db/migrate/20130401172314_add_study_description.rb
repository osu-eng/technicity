class AddStudyDescription < ActiveRecord::Migration
  def up
    add_column :studies, :description, :text
  end

  def down
  end
end
