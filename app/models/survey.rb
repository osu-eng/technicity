class Survey < ActiveRecord::Base
  attr_accessible :description, :name
  validates_presence_of :description
  validates_presence_of :name
  has_many :studies
  has_many :survey_questions
end
