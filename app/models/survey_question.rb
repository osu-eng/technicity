class SurveyQuestion < ActiveRecord::Base
  attr_accessible :description, :multiple_choice, :question, :order_by, :survey_id, :survey_options_attributes

  has_many :survey_options, dependent: :destroy
  has_many :survey_responses
  belongs_to :survey

  accepts_nested_attributes_for :survey_options, allow_destroy: true

  validates :question, presence: true

end
