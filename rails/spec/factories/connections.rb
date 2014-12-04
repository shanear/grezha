# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :connection do
    after(:build) do |connection|
      connection.contact.organization_id = connection.organization_id
      connection.contact.save
    end

    association :contact, factory: :contact, strategy: :build

    note "MyText"
    mode "MyMode"
    occurred_at "2014-02-21"
    organization_id 1
  end
end
