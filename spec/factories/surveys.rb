# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey do
    name 'My test survey'
    description 'This is a description of my test survey'

    # helps generate relationships. See https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
    # under associations
    factory :survey_with_questions do

      ignore do
        question_count 5
      end

      after(:create) do |survey, evaluator|
        FactoryGirl.create_list(:survey_question, evaluator.question_count, survey: survey)
      end
    end

    factory :survey_with_questions_and_options do

      ignore do
        question_count 5
      end

      after(:create) do |survey, evaluator|
        FactoryGirl.create_list(:survey_question_with_options, evaluator.question_count, survey: survey)
      end
    end
  end
end
