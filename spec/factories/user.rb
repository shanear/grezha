FactoryGirl.define do
  factory :user do
    name "default name"
    email "default@email.com"
    password "default_password"
    role "user"
  end
end
