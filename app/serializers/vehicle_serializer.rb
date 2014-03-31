class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :license_plate, :notes, :used_by

  embed :ids, include: true
end