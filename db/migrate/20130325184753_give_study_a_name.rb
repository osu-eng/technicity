class GiveStudyAName < ActiveRecord::Migration
  def up
    add_column :studies, :name, :string
  end

  def down
  end
end
