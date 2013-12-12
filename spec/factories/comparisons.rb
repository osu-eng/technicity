# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comparison do
    chosen_location_id 1
    rejected_location_id 2
    voter_remote_ip '127.0.0.1'
    study_id 1
    voter_session_id 'a6beb860ad431821cda687fc8dc6e583'
  end
end
