class ProgramSerializer < ActiveModel::Serializer
  attributes :id, :name

  def id
    object.remote_id
  end
end