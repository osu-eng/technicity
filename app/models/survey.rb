class Survey < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :studies
  has_many :survey_questions
end
