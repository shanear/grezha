# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participation do
    association :contact, factory: :contact, strategy: :build
    association :event, factory: :event, strategy: :build
  end
end
