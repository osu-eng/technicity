# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_response do
    survey_question_id 1
    survey_option_id 1
    study_id 1
    voter_session "MyString"
  end
end
