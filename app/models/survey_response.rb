class SurveyResponse < ActiveRecord::Base
  attr_accessible :study_id, :survey_option_id, :survey_question_id, :voter_session
  belongs_to :survey_question
  belongs_to :survey_option
  belongs_to :study
end
