class ChangeDefaultForSurveyQuestionsMultipleChoice < ActiveRecord::Migration
  def up
    change_column_default :survey_questions, :multiple_choice, false
  end

  def down
    change_column_default :survey_questions, :multiple_choice, nil
  end
end
