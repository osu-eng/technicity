class SurveyQuestion < ActiveRecord::Base
  attr_accessible :description, :multiple_choice, :name, :order_by, :survey_id
end
