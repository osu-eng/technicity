# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :region_set do
    user_id 505
    slug 'ohio-cities'
    name 'US Major Cities'
    public true
    description 'This set contains the metropolitan areas for all major US cities. This is defined roughly as "in the belt".'

    after(:create) do |region_set, evaluator|
      FactoryGirl.create_list(:region_set_membership, 1, region_set: region_set)
    end

  end

end
