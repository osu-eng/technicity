# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_question do
    survey
    question 'What color are your eyes?'
    description 'Please describe the color of your eyes'
    multiple_choice false
    order_by 1

    factory :survey_question_with_options do

      ignore do
        option_count 4
      end

      after(:create) do |survey_question, evaluator|
        FactoryGirl.create_list(:survey_option, evaluator.option_count, survey_question: survey_question)
      end
    end

  end
end
