class CreateSurveyResponses < ActiveRecord::Migration
  def change
    create_table :survey_responses do |t|
      t.integer :survey_question_id
      t.integer :survey_option_id
      t.integer :study_id
      t.string :voter_session

      t.timestamps
    end
    add_index :survey_responses, :survey_question_id
    add_index :survey_responses, :survey_option_id
    add_index :survey_responses, :study_id
  end
end
