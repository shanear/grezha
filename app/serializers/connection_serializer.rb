class ConnectionSerializer < ActiveModel::Serializer
  attributes :id, :note, :date, :contact_id
end