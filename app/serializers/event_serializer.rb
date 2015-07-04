class EventSerializer < ActiveModel::Serializer
  attributes :id, :program_id, :name, :starts_at, :location, :notes, :log_notes, :other_attendee_count, :logged_at

  def id
    object.remote_id
  end

  def program_id
    object.program && object.program.remote_id
  end
end