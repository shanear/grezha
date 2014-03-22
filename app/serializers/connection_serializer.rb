class ConnectionSerializer < ActiveModel::Serializer
  attributes :id, :note, :occurred_at, :contact_id
end