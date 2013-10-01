class SurveyQuestion < ActiveRecord::Base
  attr_accessible :description, :name, :order_by, :survey_id
end
