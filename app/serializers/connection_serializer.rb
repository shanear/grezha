class ConnectionSerializer < ActiveModel::Serializer
  attributes :id, :note, :occurred_at, :contact_id

  def id
    object.remote_id
  end

  def contact_id
    object.contact && object.contact.remote_id
  end
end