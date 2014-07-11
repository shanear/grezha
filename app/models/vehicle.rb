# == Schema Information
#
# Table name: vehicles
#
#  id              :integer          not null, primary key
#  license_plate   :string(255)
#  notes           :text
#  used_by         :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  remote_id       :string(8)        not null
#  organization_id :integer
#

class Vehicle < ActiveRecord::Base
  include RemoteSynced
  validates :license_plate, uniqueness: true
end
