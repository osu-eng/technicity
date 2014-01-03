class SurveyCreationForm
  include Virtus.model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :description, String
  attribute :study_id, Integer
  attribute :survey, Survey

  validates :study_id, presence: true
  validates :description, presence: true

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
    # Should we make this a transaction?
    @survey = Survey.create!(description: description)
    @study = Study.update(study_id, survey_id: @survey.id)
  end
end
