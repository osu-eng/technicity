class PublicDefaultOnStudies < ActiveRecord::Migration
  def up
    change_column :studies, :public, :boolean, :default => true
  end

  def down
  end
end
