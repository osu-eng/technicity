# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_response do
    survey_question
    survey_option
    study_id 1
    voter_session_id '1234'

  end
end
