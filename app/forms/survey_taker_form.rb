class SurveyTakerForm
  include Virtus.model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :description, String
  attribute :study_id, Integer
  attribute :questions, Hash

  def initialize(survey, study_id)
    self.description = survey.description
    self.study_id = study_id
    self.questions = SurveyQuestion.where(survey_id: survey.id)
  end

  # Forms are never themselves persisted
  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    # Save the form!
  end

end