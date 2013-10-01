# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_question do
    survey_id 1
    question 'What color are your eyes?'
    description 'Please describe the color of your eyes'
    multiple_choice false
    order_by 1
  end
end
