class SurveyQuestion < ActiveRecord::Base
  attr_accessible :description, :multiple_choice, :question, :order_by, :survey_id
  has_many :survey_options
  has_many :survey_responses
  belongs_to :survey
end
