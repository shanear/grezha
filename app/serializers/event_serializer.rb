class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :starts_at, :location, :notes

  def id
    object.remote_id
  end
end