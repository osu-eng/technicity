# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :study do
    region_set_id  1
    user_id 505
    name 'Ohio Cities Pretty'
    public true
    question 'Which city is prettier?'
    description 'This study identifies the prettiest parts of Ohio\'s metro areas.'
    has_survey true
    limit_votes true
    survey_required_votes 10
  end
end
