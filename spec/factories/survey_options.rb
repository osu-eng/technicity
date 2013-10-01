# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_option do
    survey_question_id 1
    option 'Blue'
    order_by 1
  end
end
