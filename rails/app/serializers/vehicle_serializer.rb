class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :license_plate, :notes, :used_by

  def id
    object.remote_id
  end
end