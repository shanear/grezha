# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vehicle do
    sequence :license_plate do |n|
      "#{n} AR"
    end

    notes "Some stuff"
    used_by "person"
  end
end
