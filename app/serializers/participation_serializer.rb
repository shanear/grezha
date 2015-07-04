class ParticipationSerializer < ActiveModel::Serializer
  attributes :id, :contact_id, :event_id, :registered_at

  def id
    object.remote_id
  end

  def contact_id
    object.contact && object.contact.remote_id
  end

  def event_id
    object.event && object.event.remote_id
  end
end