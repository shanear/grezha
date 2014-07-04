# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :relationship do
  	 after(:build) do |relationship|
      relationship.contact.organization_id = relationship.organization_id
      relationship.contact.save
    end

    association :contact, factory: :contact, strategy: :build

    notes "MyText"
    organization_id 1
    relationship_type "Officer"
  end
end
