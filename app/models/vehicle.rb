class Vehicle < ActiveRecord::Base
  include RemoteSynced
  validates :license_plate, uniqueness: true
end
