class AddUserInfoComparison < ActiveRecord::Migration
  def up
    # Rename remote_ip for consistency
    rename_column :comparisons, :remote_ip, :voter_remote_ip

    # Add session id
    add_column :comparisons, :voter_session_id, :string

    # Add lat and lng
    add_column :comparisons, :voter_latitude, :decimal, :precision => 15, :scale => 12
    add_column :comparisons, :voter_longitude, :decimal, :precision => 15, :scale => 12
  end

  def down
  end
end
