class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :contact_info, :role, :notes

  def id
    object.remote_id
  end
end