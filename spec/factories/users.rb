
FactoryGirl.define do
  factory :user do
    username 'testuser'
    name 'Test User'
    email 'example@example.com'
    password 'changeme'
    password_confirmation 'changeme'
  end
end
