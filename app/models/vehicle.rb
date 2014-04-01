class Vehicle < ActiveRecord::Base
  validates :license_plate, uniqueness: true
end
