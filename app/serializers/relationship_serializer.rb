class RelationshipSerializer < ActiveModel::Serializer
  attributes :id, :name, :contact_info, :relationship_type, :notes, :contact_id
  def id
    object.remote_id
  end

  def contact_id
    object.contact && object.contact.remote_id
  end
end