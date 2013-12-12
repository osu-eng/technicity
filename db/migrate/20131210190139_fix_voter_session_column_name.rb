class FixVoterSessionColumnName < ActiveRecord::Migration
  def change
    rename_column :survey_responses, :voter_session, :voter_session_id
  end
end
