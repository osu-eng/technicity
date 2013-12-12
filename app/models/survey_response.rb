class SurveyResponse < ActiveRecord::Base
  attr_accessible :study_id, :survey_option_id, :survey_question_id, :voter_session_id
  belongs_to :survey_question
  belongs_to :survey_option
  belongs_to :study

  def self.questions_and_answers(session_id)
    joins(:survey_question)
    .joins(:survey_option)
    .select('question, GROUP_CONCAT(survey_options.option) as answer')
    .group('survey_responses.survey_question_id')
    .where(voter_session_id: session_id)
  end
end
