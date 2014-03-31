# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vehicle do
    license_number "MyString"
    notes "MyText"
    used_by "MyString"
  end
end
