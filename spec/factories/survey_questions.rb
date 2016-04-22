# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_question do
    survey
    question 'What color are your eyes?'
    description 'Please describe the color of your eyes'
    multiple_choice false
    order_by 1

    factory :survey_question_with_options do

      transient do
        option_count 4
      end

      after(:create) do |survey_question, evaluator|
        FactoryGirl.create_list(:survey_option, evaluator.option_count, survey_question: survey_question)
      end
    end

    factory :survey_question_with_options_and_responses do

      transient do
        option_count 4
      end

      after(:create) do |survey_question, evaluator|
        s = FactoryGirl.create_list(:survey_option, evaluator.option_count, survey_question: survey_question)
        FactoryGirl.create_list(:survey_response, 2, survey_question: survey_question, survey_option: s[0])
      end
    end

  end
end
