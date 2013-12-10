class SurveyTakerForm
  include Virtus.model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :study_id, Integer
  attribute :survey_questions, SurveyQuestion
  attribute :session_id, String

  def initialize(survey_questions, args = {})
    self.survey_questions = survey_questions

    # dynamically create attributes based on the number of questions in the db
    survey_questions.each do |q|
      type = q.multiple_choice ? Array : Integer
      self.class.send :attribute, "question#{q.id}", type
    end

    # call super and pass args so Virtus can do it's thing
    super args
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
    responses = Array.new
    survey_questions.each do |q|
      response_array(q.id).each { |r| responses << r }
    end
    # Save the form!
    SurveyResponse.create(responses)
  end

  def response_array(question_id = nil)
    return [] if question_id.nil?
    #TODO: figure out how to get voter_session and save

    question_attr = "question#{question_id}"
    option_ids = self.__send__(question_attr)

    # if we working with an array return a an array of hashes
    if option_ids.class == Array
      responses = Array.new
      option_ids.each do |option|
        if option.present?
          responses << {survey_question_id: question_id,
                        survey_option_id: option,
                        study_id: study_id,
                        voter_session_id: session_id}
        end
      end
      responses
    # otherwise return the single hash
    else
      [{survey_question_id: question_id, survey_option_id: option_ids, study_id: study_id, voter_session_id: session_id}]
    end
  end

end
