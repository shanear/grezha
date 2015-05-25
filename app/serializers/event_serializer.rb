class EventSerializer < ActiveModel::Serializer
  attributes :id, :program_id, :name, :starts_at, :location, :notes

  def id
    object.remote_id
  end

  def program_id
    object.program && object.program.remote_id
  end
end