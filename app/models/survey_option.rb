class SurveyOption < ActiveRecord::Base
  attr_accessible :name, :order_by, :survey_question_id
end
