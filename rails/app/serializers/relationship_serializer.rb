class RelationshipSerializer < ActiveModel::Serializer
  attributes :id, :name, :contact_info, :relationship_type, :notes, :contact_id, :person_id
  def id
    object.remote_id
  end

  def contact_id
    object.contact && object.contact.remote_id
  end

  def person_id
    object.person && object.person.remote_id
  end
end