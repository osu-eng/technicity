# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    region
    heading 90
    pitch 90
    latitude 39.985587
    longitude -82.944621
  end
end
