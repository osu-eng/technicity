class AddBannedUsers < ActiveRecord::Migration
  def up
    add_column :users, :blocked, :boolean, :default => false
  end

  def down
  end
end
