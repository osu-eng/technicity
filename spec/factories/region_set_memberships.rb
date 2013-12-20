# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :region_set_membership do
    region_set
    region
  end
end
