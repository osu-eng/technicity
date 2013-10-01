class AddSurveyInfoToStudies < ActiveRecord::Migration
  def change
    add_column :studies, :survey_id, :integer
    add_index :studies, :survey_id
    add_column :studies, :survey_required_votes, :integer
  end
end
