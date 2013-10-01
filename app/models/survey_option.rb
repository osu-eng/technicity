class SurveyOption < ActiveRecord::Base
  attr_accessible :name, :order_by, :survey_question_id
  belongs_to :survey_question
  has_many :survey_responses
end
