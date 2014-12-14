FactoryGirl.define do
  factory :user do
    association :organization
    name "default name"
    email "default@email.com"
    password "default_password"
    role "user"
  end
end
