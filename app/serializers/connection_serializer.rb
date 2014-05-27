class ConnectionSerializer < ActiveModel::Serializer
  attributes :id, :note, :occurred_at, :contact_id

  def id
    object.remote_id
  end
end